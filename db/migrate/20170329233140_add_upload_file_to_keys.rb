class AddUploadFileToKeys < ActiveRecord::Migration[5.0]
  def change
    add_column :keys, :upload_file, :string
  end
end
