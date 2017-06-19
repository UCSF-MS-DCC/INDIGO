class DropUploadReports < ActiveRecord::Migration[5.0]
  def change
    drop_table :upload_reports
  end
end
