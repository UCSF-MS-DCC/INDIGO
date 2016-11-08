require 'test_helper'

class AdminContactControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_contact_new_url
    assert_response :success
  end

end
