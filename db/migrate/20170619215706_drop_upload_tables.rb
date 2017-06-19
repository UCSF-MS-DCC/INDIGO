class DropUploadTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :keys
    drop_table :hlauploads
    drop_table :kiruploads
  end
end
