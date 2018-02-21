class AddSourceColToHla < ActiveRecord::Migration[5.0]
  def change
    add_column :hlas, :original_data_source, :text
  end
end
