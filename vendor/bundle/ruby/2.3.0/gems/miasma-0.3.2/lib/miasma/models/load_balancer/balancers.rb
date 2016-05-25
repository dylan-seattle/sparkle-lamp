require 'miasma'

module Miasma
  module Models
    class LoadBalancer

      # Abstract load balancer collection
      class Balancers < Types::Collection

        # Return load balancers matching given filter
        #
        # @param options [Hash] filter options
        # @return [Array<Balancer>]
        def filter(options={})
          raise NotImplementedError
        end

        # @return [Balancer] collection item class
        def model
          Balancer
        end

        protected

        # @return [Array<Balancer>]
        def perform_population
          api.balancer_all
        end

      end

    end
  end
end
