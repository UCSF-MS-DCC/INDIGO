require 'test_helper'

class HlauploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hlauploads_index_url
    assert_response :success
  end

  test "should get new" do
    get hlauploads_new_url
    assert_response :success
  end

  test "should get create" do
    get hlauploads_create_url
    assert_response :success
  end

  test "should get destroy" do
    get hlauploads_destroy_url
    assert_response :success
  end

end
