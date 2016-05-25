require 'securerandom'
require 'miasma'

module Miasma
  module Models
    class Orchestration
      class Google < Orchestration

        include Contrib::Google::ApiCommon

        GOOGLE_SERVICE_PATH = '/deploymentmanager/v2'
        GOOGLE_SERVICE_PROJECT = true

        # Determine stack state based on last operation information
        #
        # @param operation [Hash]
        # @option operation [String] :operationType
        # @option operation [String] :status
        # @return [Symbol]
        def determine_state(operation)
          prefix = case operation[:operationType]
                   when 'insert'
                     'create'
                   when 'update'
                     'update'
                   when 'delete'
                     'delete'
                   end
          suffix = case operation[:status]
                   when 'RUNNING', 'PENDING'
                     'in_progress'
                   when 'DONE'
                     'complete'
                   end
          if(operation[:error])
            suffix = 'failed'
          end
          if(prefix.nil? || suffix.nil?)
            :unknown
          else
            "#{prefix}_#{suffix}".to_sym
          end
        end

        # Create stack data hash from information
        #
        # @param info [Hash]
        # @option info [String] :insertTime
        # @option info [String] :description
        # @option info [String] :name
        # @option info [Hash] :operation
        # @return [Hash]
        def basic_stack_data_format(info)
          info = info.to_smash
          Smash.new(
            :id => info[:id],
            :created => Time.parse(info[:insertTime]),
            :updated => Time.parse(info.fetch(:operation, :endTime, info.fetch(:operation, :startTime, info[:insertTime]))),
            :description => info[:description],
            :name => info[:name],
            :state => determine_state(info.fetch(:operation, {})),
            :status => determine_state(info.fetch(:operation, {})).to_s.split('_').map(&:capitalize).join(' '),
            :custom => info
          )
        end

        # @return [Array<Stack>]
        def stack_all
          result = request(
            :path => 'global/deployments'
          )
          result.fetch(:body, :deployments, []).map do |item|
            new_stack = Stack.new(self)
            new_stack.load_data(basic_stack_data_format(item)).valid_state
          end
        end

        # Save stack state
        #
        # @param stack [Stack]
        # @return [Stack]
        def stack_save(stack)
          unless(stack.persisted?)
            result = request(
              :path => 'global/deployments',
              :method => :post,
              :json => {
                :name => stack.name,
                :target => template_data_unformat(stack.template)
              }
            )
          else
            result = request(
              :path => "global/deployments/#{stack.name}",
              :method => :put,
              :json => {
                :name => stack.name,
                :target => template_data_unformat(stack.template),
                :fingerprint => stack.custom[:fingerprint]
              }
            )
          end
          stack.id = result.get(:body, :id)
          stack.valid_state
          stack.reload
        end

        # Fetch the stack template
        #
        # @param stack [Stack]
        # @return [Hash]
        def stack_template_load(stack)
          if(stack.persisted?)
            result = request(
              :endpoint => stack.custom.fetch(:manifest, stack.custom.get(:update, :manifest))
            )
            cache_template = stack.template = template_data_format(result[:body])
            stack.custom = stack.custom.merge(result[:body])
            if(stack.custom['expandedConfig'])
              stack.custom['expandedConfig'] = YAML.load(stack.custom['expandedConfig']).to_smash
            end
            if(stack.custom['layout'])
              stack.custom['layout'] = YAML.load(stack.custom['layout']).to_smash
            end
            stack.valid_state
            cache_template
          else
            Smash.new
          end
        end

        # Pack template data for shipping to API
        #
        # @param data [Hash]
        # @option data [Hash] :config
        # @option data [Array<Hash>] :imports
        # @return [Hash]
        def template_data_unformat(data)
          Hash.new.tap do |result|
            if(v = data.to_smash.get(:config, :content))
              result[:config] = {
                :content => yamlize(v)
              }
            end
            if(data[:imports])
              result[:imports] = data[:imports].map do |item|
                Smash.new(
                  :name => item['name'],
                  :content => yamlize(item['content'])
                )
              end
            end
          end
        end

        # Convert value to YAML if not string
        #
        # @param value [Object]
        # @return [String, Object]
        def yamlize(value)
          unless(value.is_a?(String))
            if(value.is_a?(Hash) && value.respond_to?(:to_hash))
              value = value.to_hash
            end
            value.to_yaml(:header => true)
          else
            value
          end
        end

        # Unpack received template data for local model instance
        #
        # @param data [Hash]
        # @option data [Hash] :config
        # @option data [Array<Hash>] :imports
        # @return [Hash]
        def template_data_format(data)
          data = data.to_smash
          Smash.new.tap do |result|
            result[:config] = data.fetch(:config, Smash.new)
            result[:imports] = data.fetch(:imports, []).map do |item|
              begin
                Smash.new(
                  :name => item[:name],
                  :content => YAML.load(item[:content])
                )
              rescue
                item
              end
            end
            if(result.get(:config, :content))
              result[:config][:content] = YAML.load(result[:config][:content]) || Smash.new
            else
              result[:config][:content] = Smash.new
            end
          end
        end

        # Reload the stack data
        #
        # @param stack [Stack]
        # @return [Stack]
        def stack_reload(stack)
          if(stack.persisted?)
            result = request(
              :path => "global/deployments/#{stack.name}"
            )
            deploy = result[:body]
            stack.load_data(basic_stack_data_format(deploy)).valid_state
            stack_template_load(stack)
            set_outputs_if_available(stack)
          end
          stack
        end

        # Set outputs into stack instance
        #
        # @param stack [Stack]
        # @return [TrueClass, FalseClass]
        def set_outputs_if_available(stack)
          outputs = extract_outputs(stack.custom.fetch(:layout, {}))
          unless(outputs.empty?)
            stack.outputs = outputs
            stack.valid_state
            true
          else
            false
          end
        end

        # Extract outputs from stack hash
        #
        # @param stack_hash [Hash]
        # @return [Array<Hash>]
        def extract_outputs(stack_hash)
          outputs = []
          if(stack_hash[:outputs])
            outputs += stack_hash[:outputs].map do |output|
              Smash.new(:key => output[:name], :value => output[:finalValue])
            end
          end
          stack_hash.fetch(:resources, []).each do |resource|
            outputs += extract_outputs(resource)
          end
          outputs
        end

        # Delete stack
        #
        # @param stack [Stack]
        # @return [TrueClass, FalseClass]
        def stack_destroy(stack)
          if(stack.persisted?)
            request(
              :path => "global/deployments/#{stack.name}",
              :method => :delete
            )
            true
          else
            false
          end
        end

        # Fetch all events
        #
        # @param stack [Stack]
        # @return [Array<Stack::Event>]
        def event_all(stack, evt_id=nil)
          result = request(
            :path => 'global/operations',
            :params => {
              :filter => "targetId eq #{stack.id}"
            }
          )
          result.fetch(:body, :operations, []).map do |event|
            status_msg = [
              event[:statusMessage],
              *event.fetch(:error, :errors, []).map{|e| e[:message]}
            ].compact.join(' -- ')
            Stack::Event.new(
              stack,
              :id => event[:id],
              :resource_id => event[:targetId],
              :resource_name => stack.name,
              :resource_logical_id => stack.name,
              :resource_state => determine_state(event),
              :resource_status => determine_state(event).to_s.split('_').map(&:capitalize).join(' '),
              :resource_status_reason => "#{event[:status]} - #{event[:progress]}% complete #{status_msg}",
              :time => Time.parse(event.fetch(:startTime, event[:insertTime]))
            ).valid_state
          end
        end

        # Fetch all stack resources
        #
        # @param stack [Stack]
        # @return [Array<Stack::Resource>]
        # @todo Add status reason extraction
        def resource_all(stack)
          request(
            :path => "global/deployments/#{stack.name}/resources"
          ).fetch('body', 'resources', []).map do |resource|
            Stack::Resource.new(stack,
              :id => resource[:id],
              :type => resource[:type],
              :name => resource[:name],
              :logical_id => resource[:name],
              :created => Time.parse(resource[:insertTime]),
              :updated => resource[:updateTime] ? Time.parse(resource[:updateTime]) : nil,
              :state => :create_complete,
              :status => 'OK',
              :status_reason => resource.fetch(:warnings, []).map{|w| w[:message]}.join(' ')
            ).valid_state
          end
        end

        # Reload resource data
        #
        # @param resource [Stack::Resource]
        # @return [Stack::Resource]
        def resource_reload(resource)
          resource.stack.resources.reload
          resource.stack.resources.get(resource.id)
        end

        # Reload event data
        #
        # @param event [Stack::Event]
        # @return event [Stack::Event]
        def event_reload(event)
          event.stack.events.reload
          event.stack.events.get(event.id)
        end

      end
    end
  end
end
