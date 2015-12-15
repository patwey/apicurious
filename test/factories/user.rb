FactoryGirl.define do
  factory :user do
    uid "1234"
    name "John Doe"
    screen_name "jdoe"
    profile_pic "http://pbs.twimg.com/profile_images/579487839567642624/Me6cyNzU_normal.jpg"
    banner_pic "https://pbs.twimg.com/profile_banners/2249777102/1426996316"
    tweets "150"
    followers "50"
    following "100"
    oauth_token "exampletoken"
    oauth_token_secret "examplesecrettoken"
  end
end
