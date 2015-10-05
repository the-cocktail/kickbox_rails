KickboxRails.configure do |config|
  # Configure validator with Kickbox.io API KEY. Uncomment next lines and keep api_url
  # and api_resource or change them if kickbox api url has been modified.
  config.api_url = 'https://api.kickbox.io'
  config.api_resource = '/v1/verify'
  config.api_key = 'API_KEY_HERE'
  config.treat_unknown_as_valid = false
end
