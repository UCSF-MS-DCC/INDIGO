class AlterDatasetToStoreHlaAvailableBySexAndCaseControl < ActiveRecord::Migration[5.0]
  def change
    rename_column :datasets, :hla_available_male, :hla_available_male_controls
    rename_column :datasets, :hla_available_female, :hla_available_female_controls
    add_column :datasets, :hla_available_male_cases, :integer
    add_column :datasets, :hla_available_female_cases, :integer
  end
end
