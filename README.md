# Mail::Validator

Validate emails using Kickbox.io API in Ruby on Rails

## Installation

Add this line to your application's Gemfile:

    gem 'mail-validator', :git => 'git://github.com/the-cocktail/mail-validator.git'

And then execute:

    $ bundle

Execute next command for generate initializer mail_validator.rb, where you can configure your kickbox.io account api_key:

    $ rails g mail:validator:install

## Usage

    # Rails
    # I18n locales are loaded automatically.
    class Person < ActiveRecord::Base
      validates_email_format :email
      # OR
      validates :email, email_format: { message: 'Email is invalid' }
    end

## Contributing

1. Fork it ( http://github.com/the-cocktail/mail-validator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
