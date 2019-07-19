class AddImmportStatusToHlas < ActiveRecord::Migration[5.0]
  def change
    add_column :hlas, :uploaded_to_immport, :boolean
    add_column :hlas, :immport_upload_date, :date
  end
end
