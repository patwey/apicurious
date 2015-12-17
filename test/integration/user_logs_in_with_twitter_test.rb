require "test_helper"

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  def setup
    stub_omniauth
  end

  test "user logs in with twitter" do
    VCR.use_cassette("twitter_service#home_timeline") do
      visit "/"
      click_link "Log In"

      assert_equal "/dashboard", current_path
      within ".user-info" do
        assert page.has_css? ".name", "John Doe"
        assert page.has_css? ".screen-name", "jdoe"
      end
    end
  end
end
