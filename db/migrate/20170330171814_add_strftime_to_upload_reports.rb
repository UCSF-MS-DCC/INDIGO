class AddStrftimeToUploadReports < ActiveRecord::Migration[5.0]
  def change
    add_column :upload_reports, :upload_datetime, :string
  end
end
