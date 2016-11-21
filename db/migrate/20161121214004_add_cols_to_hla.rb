class AddColsToHla < ActiveRecord::Migration[5.0]
  def change
    add_column :hlas, :dpa1_1, :string
    add_column :hlas, :dpa1_2, :string
    add_column :hlas, :dqa1_1, :string
    add_column :hlas, :dqa1_2, :string
    add_column :hlas, :drbo_1, :string
    add_column :hlas, :drbo_2, :string
  end
end
