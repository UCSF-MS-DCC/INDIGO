class AddNameToGwas < ActiveRecord::Migration[5.0]
  def change
    add_column :gwas, :name, :string
  end
end
