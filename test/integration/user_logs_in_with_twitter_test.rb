require 'test_helper'

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  test 'user logs in with twitter' do
    # As a guest,
    # When I visit the homepage,
    # And I click "Log In",
    # And I allow access,
    # Then my current page is my profile.

    visit '/'
    click_link 'Log In'
    # mock omniauth for successful auth
    assert_equal '/dashboard', current_path
  end
end
