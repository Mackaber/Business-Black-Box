#OmniAuth.config.logger = Rails.logger

#Omniauth Config
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['facebook_oauth_token'], ENV['facebook_oauth_token_secret'], scope: "email,publish_stream"
  provider :twitter, ENV['twitter_oauth_token'], ENV['twitter_oauth_token_secret']
end

#Twitter Config
Twitter.configure do |config|
  config.consumer_key = ENV['twitter_consumer_key']
  config.consumer_secret = ENV['twitter_consumer_secret']
  config.oauth_token = ENV['twitter_oauth_token']
  config.oauth_token_secret = ENV['twitter_oauth_token_secret']
end
