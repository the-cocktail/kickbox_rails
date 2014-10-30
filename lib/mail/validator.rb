require 'kickbox'

module Mail
  module Validator
    class << self
      attr_accessor :configuration, :provider

      def configure
        @configuration ||= Configuration.new
        yield(configuration)
        @provider = Kickbox::Client.new(self.configuration.api_key).kickbox
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
      attr_accessor :api_key

      def initialize
        @api_key = nil
      end
    end

  end
end
