module KickboxRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates KickboxRails initializer for your application"

      def copy_initializer
        template "kickbox_rails_initializer.rb", "config/initializers/kickbox_rails.rb"

        puts "Install complete!"
      end
    end
  end
end
