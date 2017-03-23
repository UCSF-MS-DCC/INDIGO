class AddUploadFileReferenceToHla < ActiveRecord::Migration[5.0]
  def change
    add_column :hlas, :version, :string
  end
end
