class FixImmportUploadDateColInKir2019 < ActiveRecord::Migration[5.0]
  def change
    rename_column :kir2019s, :import_upload_date, :immport_upload_date
  end
end
