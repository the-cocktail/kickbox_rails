# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mail/validator/version'

Gem::Specification.new do |spec|
  spec.name          = "mail-validator"
  spec.version       = Mail::Validator::VERSION
  spec.authors       = ["Samuel Navas"]
  spec.email         = ["samuel.navas@the-cocktail.com"]
  spec.summary       = %q{email validations}
  spec.description   = %q{Validates email against Kickbox service or similar}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "kickbox"

end
