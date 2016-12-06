require 'test_helper'

class DataviewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get :index
    assert_response :success
  end

  test "can load the dataview index" do
    get :index
    assert_response :success
  end
end
