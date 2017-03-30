class UploadReportsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  respond_to :html

  def index
    @upload_reports = UploadReport.all
    respond_with(@upload_reports)
  end

  def show
  end

  def new
    @upload_report = UploadReport.new
    respond_with(@upload_report)
  end

  def edit
  end

  def create
    @upload_report = UploadReport.new(upload_report_params)
    @upload_report.save
    respond_with(@upload_report)
  end

  def update
    @upload_report.update(upload_report_params)
    respond_with(@upload_report)
  end

  def display
    puts params
    @u = UploadReport.new
    @u.file = params[:data][:file]
    @u.uploaded_by = params[:data][:uploaded_by]
    @u.uploads = params[:data][:uploads]
    @u.failed_uploads = params[:data][:failed_uploads]
    @u.upload_type = params[:data][:upload_type]
    @u.duplicates = params[:data][:duplicates]
    @u.duplicate_upload = params[:data][:duplicate_upload]
    @u.error_message = params[:data][:error_message]

    if @u.save
      flash[:notice] = "Upload Report saved"
    end
  end

  def destroy
    @upload_report.destroy
    respond_with(@upload_report)
  end

  private

    def upload_report_params
      params[:upload_report]
    end
end
