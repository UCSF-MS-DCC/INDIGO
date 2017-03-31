class UploadReportsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  respond_to :html

  def index

  end

  def show

    @upload_reports = UploadReport.all.order('created_at DESC')
    @report = params[:id] ? UploadReport.find(params[:id]) : @upload_reports.first
    @new_report = UploadReport.new

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

    puts params[:upload_report][:upload_datetime]
    @upload_report = UploadReport.find_by(upload_datetime: params[:upload_report][:upload_datetime])

    respond_to do |format|
      format.html { redirect_to upload_reports_show_path(:id => @upload_report.id)}
    end
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
    @u.added = params[:data][:added]
    @u.failed = params[:data][:failed]

    if @u.save
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
