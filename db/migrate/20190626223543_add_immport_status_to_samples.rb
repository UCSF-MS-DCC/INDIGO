class AddImmportStatusToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :uploaded_to_immport, :boolean
    add_column :samples, :immport_upload_date, :date
  end
end
