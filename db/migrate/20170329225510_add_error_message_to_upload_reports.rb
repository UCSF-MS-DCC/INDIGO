class AddErrorMessageToUploadReports < ActiveRecord::Migration[5.0]
  def change
    add_column :upload_reports, :error_message, :text
  end
end
