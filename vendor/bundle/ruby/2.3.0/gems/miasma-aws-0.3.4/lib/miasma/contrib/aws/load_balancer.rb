require 'miasma'

module Miasma
  module Models
    class LoadBalancer
      class Aws < LoadBalancer

        include Contrib::AwsApiCore::ApiCommon
        include Contrib::AwsApiCore::RequestUtils

        # Service name of API
        API_SERVICE = 'elasticloadbalancing'
        # Supported version of the ELB API
        API_VERSION = '2012-06-01'

        # Save load balancer
        #
        # @param balancer [Models::LoadBalancer::Balancer]
        # @return [Models::LoadBalancer::Balancer]
        def balancer_save(balancer)
          unless(balancer.persisted?)
            params = Smash.new(
              'LoadBalancerName' => balancer.name
            )
            availability_zones.each_with_index do |az, i|
              params["AvailabilityZones.member.#{i+1}"] = az
            end
            if(balancer.listeners)
              balancer.listeners.each_with_index do |listener, i|
                key = "Listeners.member.#{i + 1}"
                params["#{key}.Protocol"] = listener.protocol
                params["#{key}.InstanceProtocol"] = listener.instance_protocol
                params["#{key}.LoadBalancerPort"] = listener.load_balancer_port
                params["#{key}.InstancePort"] = listener.instance_port
                if(listener.ssl_certificate_id)
                  params["#{key}.SSLCertificateId"] = listener.ssl_certificate_id
                end
              end
            end
            result = request(
              :method => :post,
              :path => '/',
              :form => params.merge(
                Smash.new(
                  'Action' => 'CreateLoadBalancer'
                )
              )
            )
            balancer.public_addresses = [
              :address => result.get(:body, 'CreateLoadBalancerResponse', 'CreateLoadBalancerResult', 'DNSName')
            ]
            balancer.load_data(:id => balancer.name).valid_state
            if(balancer.health_check)
              balancer_health_check(balancer)
            end
            if(balancer.servers && !balancer.servers.empty?)
              balancer_set_instances(balancer)
            end
          else
            if(balancer.dirty?)
              if(balancer.dirty?(:health_check))
                balancer_health_check(balancer)
              end
              if(balancer.dirty?(:servers))
                balancer_set_instances(balancer)
              end
              balancer.reload
            end
            balancer
          end
        end

        # Save the load balancer health check
        #
        # @param balancer [Models::LoadBalancer::Balancer]
        # @return [Models::LoadBalancer::Balancer]
        def balancer_health_check(balancer)
          balancer
        end

        # Save the load balancer attached servers
        #
        # @param balancer [Models::LoadBalancer::Balancer]
        # @return [Models::LoadBalancer::Balancer]
        def balancer_set_instances(balancer)
          balancer
        end

        # Reload the balancer data from the API
        #
        # @param balancer [Models::LoadBalancer::Balancer]
        # @return [Models::LoadBalancer::Balancer]
        def balancer_reload(balancer)
          if(balancer.persisted?)
            begin
              load_balancer_data(balancer)
            rescue Miasma::Error::ApiError::RequestError => e
              if(e.response_error_msg.include?('LoadBalancerNotFound'))
                balancer.state = :terminated
                balancer.status = 'terminated'
                balancer.valid_state
              else
                raise
              end
            end
          end
          balancer
        end

        # Fetch balancers or update provided balancer data
        #
        # @param balancer [Models::LoadBalancer::Balancer]
        # @return [Array<Models::LoadBalancer::Balancer>]
        def load_balancer_data(balancer=nil)
          params = Smash.new('Action' => 'DescribeLoadBalancers')
          if(balancer)
            params.merge!('LoadBalancerNames.member.1' => balancer.id || balancer.name)
          end
          result = all_result_pages(nil, :body, 'DescribeLoadBalancersResponse', 'DescribeLoadBalancersResult', 'LoadBalancerDescriptions', 'member') do |options|
            request(
              :method => :post,
              :path => '/',
              :form => options.merge(params)
            )
          end
          if(balancer)
            health_result = all_result_pages(nil, :body, 'DescribeInstanceHealthResponse', 'DescribeInstanceHealthResult', 'InstanceStates', 'member') do |options|
              request(
                :method => :post,
                :path => '/',
                :form => options.merge(
                  'LoadBalancerName' => balancer.id || balancer.name,
                  'Action' => 'DescribeInstanceHealth'
                )
              )
            end
          end
          result.map do |blr|
            (balancer || Balancer.new(self)).load_data(
              Smash.new(
                :id => blr['LoadBalancerName'],
                :name => blr['LoadBalancerName'],
                :state => :active,
                :status => 'ACTIVE',
                :created => blr['CreatedTime'],
                :updated => blr['CreatedTime'],
                :public_addresses => [
                  Balancer::Address.new(
                    :address => blr['DNSName'],
                    :version => 4
                  )
                ],
                :servers => [blr.get('Instances', 'member')].flatten(1).compact.map{|i|
                  Balancer::Server.new(self.api_for(:compute), :id => i['InstanceId'])
                }
              ).merge(
                health_result.nil? ? {} : Smash.new(
                  :server_states => health_result.nil? ? nil : health_result.map{|i|
                    Balancer::ServerState.new(self.api_for(:compute), :id => i['InstanceId'], :status => i['State'], :reason => i['ReasonCode'], :state => i['State'] == 'InService' ? :up : :down)
                  }
                )
              )
            ).valid_state
          end
        end

        # Delete load balancer
        #
        # @param balancer [Models::LoadBalancer::Balancer]
        # @return [TrueClass, FalseClass]
        def balancer_destroy(balancer)
          if(balancer.persisted?)
            request(
              :method => :post,
              :path => '/',
              :form => Smash.new(
                'Action' => 'DeleteLoadBalancer',
                'LoadBalancerName' => balancer.name
              )
            )
            balancer.state = :pending
            balancer.status = 'DELETE_IN_PROGRESS'
            balancer.valid_state
            true
          else
            false
          end
        end

        # Return all load balancers
        #
        # @param options [Hash] filter
        # @return [Array<Models::LoadBalancer::Balancer>]
        def balancer_all(options={})
          load_balancer_data
        end

        protected

        # @return [Array<String>] availability zones
        def availability_zones
          memoize(:availability_zones) do
            res = api_for(:compute).request(
              :method => :post,
              :path => '/',
              :form => Smash.new(
                'Action' => 'DescribeAvailabilityZones'
              )
            ).fetch(:body, 'DescribeAvailabilityZonesResponse', 'availabilityZoneInfo', 'item', [])
            [res].flatten.compact.map do |item|
              if(item['zoneState'] == 'available')
                item['zoneName']
              end
            end.compact
          end
        end

      end
    end
  end
end
