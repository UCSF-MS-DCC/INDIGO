class AddVersionToHlauploads < ActiveRecord::Migration[5.0]
  def change
    add_column :hlauploads, :version, :string
  end
end
