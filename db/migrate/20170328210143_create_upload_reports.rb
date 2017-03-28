class CreateUploadReports < ActiveRecord::Migration[5.0]
  def change
    create_table :upload_reports do |t|

      t.timestamps
    end
  end
end
