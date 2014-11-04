# KickboxRails

Validate emails using Kickbox.io API in Ruby on Rails and fallback to basic syntax email validation if Kickbox.io API fails for any reason


## Installation

Add this line to your application's Gemfile:

    gem 'kickbox_rails', :git => 'git://github.com/the-cocktail/kickbox_rails.git'

And then execute:

    $ bundle

Execute next command for generate initializer kickbox_rails.rb, where you can configure your kickbox.io account api_key:

    $ rails g kickbox_rails:install

## Usage

    # Rails
    class Person < ActiveRecord::Base
      validates_kickbox_email_format :email
      # OR
      validates :email, kickbox_email_format: { message: 'Email is invalid' }
    end

    # Non Rails
    KickboxRails.valid?("example@email.com")
    KickboxRails.invalid?("example@email.com")

    If you want to get related info from kickbox.io API use validate method

    KickboxRails.validate("bill.lumbergh@gamil.com") =>

    {
      "result":"invalid",
      "reason":"rejected_email",
      "role":false,
      "free":false,
      "disposable":false,
      "accept_all":false,
      "did_you_mean":"bill.lumbergh@gmail.com",
      "sendex":0,
      "email":"bill.lumbergh@gamil.com",
      "user":"bill.lumbergh",
      "domain":"gamil.com",
      "success":true,
      "message":null
    }


## Contributing

1. Fork it ( http://github.com/the-cocktail/kickbox_rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
