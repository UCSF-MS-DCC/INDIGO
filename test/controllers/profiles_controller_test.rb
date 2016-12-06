require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    get profiles_show_url
    assert_response :success
  end

end
