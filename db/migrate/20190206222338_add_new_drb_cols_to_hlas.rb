class AddNewDrbColsToHlas < ActiveRecord::Migration[5.0]
  def change
    add_column :hlas, :drb345_1, :string
    add_column :hlas, :drb345_2, :string
  end
end
