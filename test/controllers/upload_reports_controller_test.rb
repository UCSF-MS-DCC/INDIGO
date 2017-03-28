require 'test_helper'

class UploadReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @upload_report = upload_reports(:one)
  end

  test "should get index" do
    get upload_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_upload_report_url
    assert_response :success
  end

  test "should create upload_report" do
    assert_difference('UploadReport.count') do
      post upload_reports_url, params: { upload_report: {  } }
    end

    assert_redirected_to upload_report_url(UploadReport.last)
  end

  test "should show upload_report" do
    get upload_report_url(@upload_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_upload_report_url(@upload_report)
    assert_response :success
  end

  test "should update upload_report" do
    patch upload_report_url(@upload_report), params: { upload_report: {  } }
    assert_redirected_to upload_report_url(@upload_report)
  end

  test "should destroy upload_report" do
    assert_difference('UploadReport.count', -1) do
      delete upload_report_url(@upload_report)
    end

    assert_redirected_to upload_reports_url
  end
end
