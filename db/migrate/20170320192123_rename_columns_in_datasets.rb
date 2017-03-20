class RenameColumnsInDatasets < ActiveRecord::Migration[5.0]
  def change
    rename_column :datasets, :total_subjects_male, :total_samples_male
    rename_column :datasets, :total_subjects_female, :total_samples_female
    rename_column :datasets, :cases_male, :samples_male_cases
    rename_column :datasets, :cases_female, :samples_female_cases
    rename_column :datasets, :controls_male, :samples_male_controls
    rename_column :datasets, :controls_female, :samples_female_controls
  end
end
