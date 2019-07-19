class AddImmportStatusToKirs < ActiveRecord::Migration[5.0]
  def change
    add_column :kirs, :uploaded_to_immport, :boolean
    add_column :kirs, :immport_upload_date, :date
  end
end
