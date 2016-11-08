require 'test_helper'

class InfographicsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get infographics_show_url
    assert_response :success
  end

end
