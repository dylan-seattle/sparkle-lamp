require 'miasma'

module Miasma
  module Models
    class Compute
      # Abstract server
      class Server < Types::Model

        # @return [Array<Symbol>] valid compute instance states
        VALID_COMPUTE_STATES = [:running, :stopped, :pending, :terminated]

        # Data container for networks
        #
        # @todo add model link
        class Network < Types::ThinModel
          attribute :name, String
        end

        # Data container for IP addresses
        class Address < Types::Data
          attribute :version, Integer, :required => true, :default => 4
          attribute :address, String, :required => true
          attribute :label, String
        end

        attribute :name, String, :required => true
        attribute :image_id, [String, Numeric]
        attribute :flavor_id, [String, Numeric]
        attribute :state, Symbol, :allowed => VALID_COMPUTE_STATES
        attribute :status, String
        attribute :addresses_public, Address, :multiple => true, :coerce => lambda{|v| Address.new(v)}
        attribute :addresses_private, Address, :multiple => true, :coerce => lambda{|v| Address.new(v)}
        attribute :networks, Network, :multiple => true, :coerce => lambda{|v| Network.new(v)}
        attribute :personality, [Hash, String], :default => {}
        attribute :metadata, Hash, :coerce => lambda{|o| o.to_smash}
        attribute :key_name, String

        on_missing :reload

        # @return [Array<Smash>]
        def addresses
          addresses_public + addresses_private
        end

        # @return [String] public IP address
        def address
          obj = addresses_public.detect do |addr|
            addr.version == 4
          end
          obj.address if obj
        end

        protected

        # Proxy save action up to the API
        def perform_save
          api.server_save(self)
        end

        # Proxy reload action up to the API
        def perform_reload
          api.server_reload(self)
        end

        # Proxy destroy action up to the API
        def perform_destroy
          api.server_destroy(self)
        end
      end

    end
  end
end
