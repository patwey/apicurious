require "test_helper"

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  def setup
    stub_omniauth
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
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

  test "user logs in with twitter" do
    visit "/"
    click_link "Log In"

    assert_equal "/dashboard", current_path
    within ".user-info" do
      assert page.has_css? ".name", "John Doe"
      assert page.has_css? ".screen-name", "jdoe"
    end
  end
end
