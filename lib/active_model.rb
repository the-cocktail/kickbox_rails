require 'kickbox_rails'
require 'i18n'

module ActiveModel
  module Validations
    class EmailFormatValidator < EachValidator

      DEFAULT_MESSAGE = "Email is invalid"

      def validate_each(record, attribute, value)
        if KickboxRails::invalid?(value)
          record.errors[attribute] << (defined?(I18n) ? I18n.t(:invalid_email_address, :default => (options[:message]||DEFAULT_MESSAGE), :locale => I18n.default_locale) : (options[:message]||DEFAULT_MESSAGE))
        end
      end
    end

    module HelperMethods
      def validates_email_format(*attr_names)
        validates_with EmailFormatValidator, _merge_attributes(attr_names)
      end
    end
  end
end
