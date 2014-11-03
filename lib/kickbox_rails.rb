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
        puts "llamamos a api y devuelve #{response}"
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
      response['result'] == 'valid' ? true : false
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
    attr_accessor :api_key, :api_url, :api_resource

    def initialize
      @api_key = nil
      @api_url = nil
      @api_resource = nil
    end
  end
end


require 'active_model' if defined?(::ActiveModel) && !(ActiveModel::VERSION::MAJOR < 2 || (2 == ActiveModel::VERSION::MAJOR && ActiveModel::VERSION::MINOR < 1))
