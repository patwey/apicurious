class User < ActiveRecord::Base
  def service
    TwitterService.new(self)
  end

  def self.from_omniauth(auth_info)
    where(uid: auth_info.uid).first_or_create do |new_user|
      new_user.uid = auth_info.extra.raw_info.user_id
      new_user.name = auth_info.extra.raw_info.name
      new_user.screen_name = auth_info.extra.raw_info.screen_name
      new_user.tweets = auth_info.extra.raw_info.statuses_count
      new_user.followers = auth_info.extra.raw_info.followers_count
      new_user.following = auth_info.extra.raw_info.friends_count
      new_user.profile_pic = auth_info.extra.raw_info.profile_image_url
      new_user.banner_pic = auth_info.extra.raw_info.profile_banner_url
      new_user.oauth_token = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end

  def home_timeline
    service.home_timeline
  end

  def tweet(text)
    service.tweet(text)
  end
end
