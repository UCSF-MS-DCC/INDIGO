class AddCasesAndControlsToBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :batches, :cases, :integer
    add_column :batches, :controls, :integer
  end
end
