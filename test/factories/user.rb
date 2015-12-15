FactoryGirl.define do
  factory :user do
    uid "1234"
    name "John Doe"
    screen_name "jdoe"
    oauth_token "exampletoken"
    oauth_token_secret "examplesecrettoken"
  end
end
