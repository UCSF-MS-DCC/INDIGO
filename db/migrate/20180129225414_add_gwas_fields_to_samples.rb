class AddGwasFieldsToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :gwas_name, :string
    add_column :samples, :gwas_url, :text
  end
end
