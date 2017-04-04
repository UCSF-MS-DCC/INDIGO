class AddUrlToGwas < ActiveRecord::Migration[5.0]
  def change
    add_column :gwas, :url, :string
  end
end
