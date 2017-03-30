class UploadReport < ApplicationRecord
  after_create :set_upload_datetime

  def set_upload_datetime
    self.upload_datetime = self.created_at.strftime('%m-%e-%y %I:%M %p')
    self.save
  end

  def report_times
    return UploadReport.order('created_at DESC').all.pluck(:upload_datetime)
  end
end
