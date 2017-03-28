class AddDuplicateUploadToUploadReports < ActiveRecord::Migration[5.0]
  def change
    add_column :upload_reports, :duplicate_upload, :boolean
  end
end
