class AddImmportStatusToKir2019s < ActiveRecord::Migration[5.0]
  def change
    add_column :kir2019s, :uploaded_to_immport, :boolean
    add_column :kir2019s, :import_upload_date, :date 
  end
end
