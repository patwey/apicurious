require "test_helper"

class TwitterServiceTest < ActiveSupport::TestCase
  attr_reader :service

  def setup
    user = OpenStruct.new(oauth_token: ENV["twitter_access_token"],
                          oauth_token_secret: ENV["twitter_access_token_secret"])
    @service = TwitterService.new(user)
  end

  test "#home_timeline" do
    VCR.use_cassette("twitter_service#home_timeline") do
      home_timeline = service.home_timeline
      tweet = home_timeline.first

      assert_equal 20, home_timeline.count
      assert_equal "IRC Intl Rescue Comm", tweet.user.name
    end
  end

  test "#tweet" do
    VCR.use_cassette("twitter_service#tweet") do
      tweet_msg = "My tweet"
      tweet = service.tweet(tweet_msg)

      assert_equal "My tweet", tweet.text
    end
  end

  test "#reply" do
    VCR.use_cassette("twitter_service#reply") do
      reply_text = "@theIRC wow"
      reply_to_id = 677285650354339841
      reply = service.reply(reply_text, reply_to_id)

      assert_equal "@theIRC wow", reply.text
      assert_equal "patwey", reply.user.screen_name
    end
  end

  test "#retweet" do
    VCR.use_cassette("twitter_service#retweet") do
      tweet_id = 677285650354339841
      expected_retweet_text = 'RT @theIRC: "They terrorized my daughters &amp; killed my baby" Diary of a Syrian refugee: https://t.co/KdbpC9URl0 @WashingtonPost https://t.co…'
      retweet = service.retweet(tweet_id).first

      assert_equal "patwey", retweet.user.screen_name
      assert_equal expected_retweet_text, retweet.text
    end
  end

  test "#favorite" do
    VCR.use_cassette("twitter_service#favorite") do
      tweet_id = 677285650354339841
      favorite = service.favorite(tweet_id).first

      assert_equal 677285650354339841, favorite.id
    end
  end
end
