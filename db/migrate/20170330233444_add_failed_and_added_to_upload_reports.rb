class AddFailedAndAddedToUploadReports < ActiveRecord::Migration[5.0]
  def change
    add_column :upload_reports, :added, :integer
    add_column :upload_reports, :failed, :integer
  end
end
