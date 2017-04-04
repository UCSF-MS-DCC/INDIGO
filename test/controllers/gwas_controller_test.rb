require 'test_helper'

class GwasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gwa = gwas(:one)
  end

  test "should get index" do
    get gwas_index_url
    assert_response :success
  end

  test "should get new" do
    get new_gwa_url
    assert_response :success
  end

  test "should create gwa" do
    assert_difference('Gwas.count') do
      post gwas_index_url, params: { gwa: {  } }
    end

    assert_redirected_to gwa_url(Gwas.last)
  end

  test "should show gwa" do
    get gwa_url(@gwa)
    assert_response :success
  end

  test "should get edit" do
    get edit_gwa_url(@gwa)
    assert_response :success
  end

  test "should update gwa" do
    patch gwa_url(@gwa), params: { gwa: {  } }
    assert_redirected_to gwa_url(@gwa)
  end

  test "should destroy gwa" do
    assert_difference('Gwas.count', -1) do
      delete gwa_url(@gwa)
    end

    assert_redirected_to gwas_index_url
  end
end
