require 'test_helper'

class HlasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hlas_index_url
    assert_response :success
  end

  test "should get new" do
    get hlas_new_url
    assert_response :success
  end

  test "should get create" do
    get hlas_create_url
    assert_response :success
  end

  test "should get destroy" do
    get hlas_destroy_url
    assert_response :success
  end

end
