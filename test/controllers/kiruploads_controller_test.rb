require 'test_helper'

class KiruploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get kiruploads_index_url
    assert_response :success
  end

  test "should get new" do
    get kiruploads_new_url
    assert_response :success
  end

  test "should get create" do
    get kiruploads_create_url
    assert_response :success
  end

  test "should get destroy" do
    get kiruploads_destroy_url
    assert_response :success
  end

end
