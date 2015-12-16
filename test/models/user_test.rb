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

  test "from_omniauth creates user with given uid" do
    user = User.from_omniauth(auth_info)
    assert_equal user, User.find_by(uid: user.uid)
  end
end
