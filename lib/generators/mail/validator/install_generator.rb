module Mail
  module Validator
    module Generators
      class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path("../../templates", __FILE__)
        desc "Creates Mail::Validator initializer for your application"

        def copy_initializer
          template "mail_validator_initializer.rb", "config/initializers/mail_validator.rb"

          puts "Install complete!"
        end
      end
    end
  end
end
