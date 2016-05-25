require 'miasma'
require 'base64'
require 'digest/sha2'
require 'openssl'

module Miasma

  module Contrib

    module Google

      # Base signature class
      class Signature

        # @return [String] algorithm of signature
        attr_reader :algorithm
        # @return [String] format of signature
        attr_reader :format
        # @return [Smash] signature claims
        attr_reader :claims

        # Create a new signature
        #
        # @param [String, Symbol] algorithm used for signature
        # @param [String, Symbol] format of signature
        # @param claims [Hash] request claims
        # @return [self]
        def initialize(algo, fmt, clms)
          @algorithm = algo
          @format = fmt
          @claims = clms.to_smash
        end

        # Generate signature
        #
        # @return [String]
        def generate
          raise NotImplementedError
        end

        # JSON Web Token signature
        class Jwt < Signature

          # Required items within claims
          REQUIRED_CLAIMS = [
            :iss, # email address of service account
            :scope, # space-delimited list of permissions requested
            :aud, # intended target of assertion
            :exp, # expiration time of assertion
            :iat # time assertion was issued
          ]

          # Create a new JWT signature instance
          #
          # @param private_key_path [String] private signing key path
          # @param claims [Hash] request claims
          # @return [self]
          def initialize(private_key_path, i_claims)
            super('RS256', 'JWT', i_claims)
            claims[:iat] ||= Time.now.to_i
            claims[:exp] ||= Time.now.to_i + 120
            @private_key = private_key_path
            validate_claims!
            validate_key!
          end

          # Generate signature
          #
          # @return [String]
          def generate
            "#{encoded_header}.#{encoded_claims}.#{encoded_signature}"
          end

          # @return [String] encoded header
          def encoded_header
            Base64.urlsafe_encode64(header.to_json)
          end

          # @return [String] header
          def header
            Smash.new(
              :alg => algorithm,
              :typ => format
            )
          end

          # @return [String] encoded claims set
          def encoded_claims
            t_claims = claims.to_smash
            if(t_claims.key?(:scope))
              t_claims[:scope] = [t_claims[:scope]].flatten.compact.join(' ')
            end
            Base64.urlsafe_encode64(t_claims.to_json)
          end

          # @return [String] encoded signature
          def encoded_signature
            Base64.urlsafe_encode64(signature)
          end

          # @return [String] JWT signature
          def signature
            token = "#{encoded_header}.#{encoded_claims}"
            hasher = OpenSSL::Digest::SHA256.new
            author = OpenSSL::PKey::RSA.new(File.read(@private_key))
            author.sign(hasher, token)
          end

          # Check for required claims and raise error if unset
          #
          # @return [TrueClass]
          # @raises [KeyError]
          def validate_claims!
            REQUIRED_CLAIMS.each do |claim|
              unless(claims.key?(claim))
                raise KeyError.new "Missing required claim key `#{claim}`"
              end
            end
            true
          end

          # Check that the private key exists, is readable, and is
          def validate_key!
          end

        end

      end

      module ApiCommon

        def self.included(klass)
          klass.class_eval do
            attribute :google_service_account_email, String, :required => true
            attribute :google_service_account_private_key, String, :required => true
            attribute :google_auth_scope, String, :required => true, :multiple => true, :default => 'cloud-platform'
            attribute :google_auth_base, String, :default => 'https://www.googleapis.com/auth'
            attribute :google_assertion_target, String, :required => true, :default => 'https://www.googleapis.com/oauth2/v4/token'
            attribute :google_assertion_expiry, Integer, :required => true, :default => 120
            attribute :google_project, String, :required => true
            attribute :google_api_base_endpoint, String, :required => true, :default => 'https://www.googleapis.com'
          end

          klass.const_set(:TOKEN_GRANT_TYPE, 'urn:ietf:params:oauth:grant-type:jwt-bearer')
        end

        # @return [String]
        def endpoint
          point = google_api_base_endpoint.dup
          if(self.class.const_defined?(:GOOGLE_SERVICE_PATH))
            point << "/#{self.class.const_get(:GOOGLE_SERVICE_PATH)}"
          end
          if(self.class.const_defined?(:GOOGLE_SERVICE_PROJECT) && self.class.const_get(:GOOGLE_SERVICE_PROJECT))
            point << "/projects/#{google_project}"
          end
          point
        end

        # Setup for API connections
        def connect
          @oauth_token_information = Smash.new
        end

        def oauth_token_information
          @oauth_token_information
        end

        # @return [HTTP] connection for requests (forces headers)
        def connection
          super.headers(
            'Authorization' => "Bearer #{client_access_token}"
          )
        end

        # @return [Contrib::Google::Signature::Jwt]
        def signer
          Contrib::Google::Signature::Jwt.new(
            google_service_account_private_key,
            :iss => google_service_account_email,
            :scope => [google_auth_scope].flatten.compact.map{|scope|
              "#{google_auth_base}/#{scope}"
            },
            :aud => google_assertion_target,
            :exp => Time.now.to_i + google_assertion_expiry
          )
        end

        # Request a new authentication token from the remote API
        #
        # @return [Smash] token information - :access_token, :token_type, :expires_in, :expires_on
        def request_client_token
          token_signer = signer
          result = HTTP.post(
            google_assertion_target,
            :form => {
              :grant_type => self.class.const_get(:TOKEN_GRANT_TYPE),
              :assertion => token_signer.generate
            }
          )
          unless(result.code == 200)
            raise Miasma::Error::ApiError.new(
              'Request for client authentication token failed',
              :response => result
            )
          end
          @oauth_token_information = MultiJson.load(result.body.to_s).to_smash
          @oauth_token_information[:expires_on] = Time.at(
            @oauth_token_information[:expires_in] + token_signer.claims[:iat].to_i
          )
          @oauth_token_information
        end

        # @return [String] auth token
        def client_access_token
          request_client_token if access_token_expired?
          oauth_token_information[:access_token]
        end

        # @return [TrueClass, FalseClass]
        def access_token_expired?
          if(oauth_token_information[:expires_on])
            oauth_token_information[:expires_on] < Time.now
          else
            true
          end
        end

        # When in debug mode, do not retry requests
        #
        # @return [TrueClass, FalseClass]
        def retryable_allowed?(*_)
          if(ENV['DEBUG'])
            false
          else
            super
          end
        end

        # Define when request should be retried
        #
        # @param exception [Exception]
        # @return [TrueClass, FalseClass]
        def perform_request_retry(exception)
          if(exception.is_a?(Error::ApiError::RequestError))
            exception.response.code >= 500
          else
            false
          end
        end

      end
    end
  end

  Models::Storage.autoload :Google, 'miasma/contrib/google/storage'
  Models::Orchestration.autoload :Google, 'miasma/contrib/google/orchestration'

  # Models::Compute.autoload :Google, 'misama/contrib/google/compute'
  # Models::LoadBalancer.autoload :Google, 'misama/contrib/google/load_balancer'
  # Models::AutoScale.autoload :Google, 'misama/contrib/google/auto_scale'
end
