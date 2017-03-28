class AddColsToUploadReports < ActiveRecord::Migration[5.0]
  def change
    add_column :upload_reports, :file, :string
    add_column :upload_reports, :uploads, :integer
    add_column :upload_reports, :failed_uploads, :integer
    add_column :upload_reports, :upload_type, :string
    add_column :upload_reports, :uploaded_by, :integer
  end
end
