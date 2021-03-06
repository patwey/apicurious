class TwitterService
  attr_reader :client

  def initialize(user)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_api_key"]
      config.consumer_secret     = ENV["twitter_secret_key"]
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def home_timeline
    client.home_timeline
  end

  def tweet(text)
    client.update(text)
  end

  def reply(text, id)
    client.update(text, in_reply_to_status_id: id)
  end

  def retweet(id)
    client.retweet(id)
  end

  def favorite(id)
    client.favorite(id)
  end
end
