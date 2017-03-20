class AddHlaAndKirAvailableBySexToDatasets < ActiveRecord::Migration[5.0]
  def change
    add_column :datasets, :hla_available_male, :integer
    add_column :datasets, :hla_available_female, :integer
    add_column :datasets, :kir_available_male, :integer
    add_column :datasets, :kir_available_female, :integer
  end
end
