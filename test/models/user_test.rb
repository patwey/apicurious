require "test_helper"

class UserTest < ActiveSupport::TestCase
  def auth_info
    OmniAuth::AuthHash.new({
      provider: "twitter",
      extra: {
        raw_info: {
          user_id: "1234",
          name: "John Doe",
          screen_name: "jdoe"
        }
      },
      credentials: {
        token: "exampletoken",
        secret: "examplesecrettoken"
      }
    })
  end

  test "#from_omniauth creates user with given uid" do
    user = User.from_omniauth(auth_info)
    assert_equal user, User.find_by(uid: user.uid)
  end

  test "#format_reply formats tweet text and screen name into a reply" do
    reply_screen_name = "ChaimReaction"
    reply_text = "<- Woah."
    formatted_reply = User.new.format_reply(reply_screen_name, reply_text)

    assert_equal "@ChaimReaction <- Woah.", formatted_reply
  end

  test "#home_timeline returns recent tweets for a user" do
    user = build_stubbed(:user)
    VCR.use_cassette("user#home_timeline") do
      home_timeline = user.home_timeline
      first_tweet_text = "Firefox Users Can Now Watch Netflix HTML5 Video on Windows https://t.co/zfu14ZuvXa"

      assert_equal 20, home_timeline.count
      assert_equal first_tweet_text, home_timeline.first.text
    end
  end

  test "#tweet sends a tweet for a user" do
    user = build_stubbed(:user)
    VCR.use_cassette("user#tweet") do
      tweet_msg = "The tweet!"
      tweet = user.tweet(tweet_msg)

      assert_equal "The tweet!", tweet.text
    end
  end

  test "#reply sends a tweet for a user" do
    user = build_stubbed(:user)
    VCR.use_cassette("user#reply") do
      reply_msg = "I'm over it"
      reply_user = "joshuamejia"
      reply_tweet_id = 677376075215724545
      reply = user.reply(reply_msg, reply_user, reply_tweet_id)

      assert_equal "@joshuamejia I'm over it", reply.text
      assert_equal "patwey", reply.user.screen_name
    end
  end

  test "#favorite favorites a tweet for a user" do
    user = build_stubbed(:user)
    VCR.use_cassette("user#favorite") do
      tweet_id = 677232256650473473
      favorited_tweet = user.favorite(tweet_id).first
      expected_favorited_text = "Today I'm working with students trying to consume APIs!! @turingschool @adajensen"

      assert_equal 677232256650473473, favorited_tweet.id
      assert_equal expected_favorited_text, favorited_tweet.text
    end
  end

  test "#retweet retweets a tweet for a user" do
    user = build_stubbed(:user)
    VCR.use_cassette("user#retweet") do
      tweet_id = 671772313453355008
      retweeted_tweet = user.retweet(tweet_id).first
      expected_retweeted_text = "RT @AJCarmer: If I bought a cow would you massage it for me?"

      assert_equal "patwey", retweeted_tweet.user.screen_name
      assert_equal expected_retweeted_text, retweeted_tweet.text
    end
  end
end
