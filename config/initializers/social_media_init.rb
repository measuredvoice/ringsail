TWITTER_CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['REGISTRY_TWITTER_KEY']
  config.consumer_secret     = ENV['REGISTRY_TWITTER_SECRET']
end

Koala.config.api_version="v2.10"



# Koala.config.api_version="v2.10"