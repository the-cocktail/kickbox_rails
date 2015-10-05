require 'json'
require 'faraday'
require 'kickbox_api'


module KickboxRails
  class << self
    attr_accessor :configuration, :provider

    def configure
      @configuration ||= Configuration.new
      yield(configuration)
      @provider = KickboxApi.new(url: @configuration.api_url,
                                    end_point: @configuration.api_resource,
                                    token: @configuration.api_key)
    end

    def validate email
      begin
        response = @provider.verify(email||String.new)
        # fallbacks if provider return success = false
        throw Exception unless response['success']

        response

      rescue Exception => e
        # If Kickbox service respond with Error we do fallback to basic validation
        basic_email_validation email
      end
    end

    def valid? email
      response = validate(email)
      valid_response?(response['result'])
    end

    def valid_response?(response)
      if @configuration.treat_unknown_as_valid
        [ 'valid', 'unknown' ].include?(response['result'])
      else
        [ 'valid' ].include?(response['result'])
      end
    end

    def invalid? email
      !valid? email
    end

    private

    # Basic validation with standard regexp for emails
    def basic_email_validation email, options = {}
      result = if (email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i).nil?
        {
          'result' => 'invalid',
          'reason' => options[:reason] || "invalid_email"
        }
      else
        {
          'result' => 'valid',
        }
      end
    end
  end

  class Configuration
    attr_accessor :api_key, :api_url, :api_resource, :treat_unknown_as_valid

    def initialize
      @api_key = nil
      @api_url = nil
      @api_resource = nil
      @treat_unknown_as_valid = false
    end
  end
end


require 'kickbox_email_format_validator' if defined?(::ActiveModel) && !(ActiveModel::VERSION::MAJOR < 2 || (2 == ActiveModel::VERSION::MAJOR && ActiveModel::VERSION::MINOR < 1))
