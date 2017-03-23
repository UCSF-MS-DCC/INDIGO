class AddVersionToKirs < ActiveRecord::Migration[5.0]
  def change
    add_column :kirs, :version, :string
  end
end
