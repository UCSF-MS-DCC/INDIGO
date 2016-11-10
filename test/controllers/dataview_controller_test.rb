require 'test_helper'

class DataviewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dataview_index_url
    assert_response :success
  end

end
