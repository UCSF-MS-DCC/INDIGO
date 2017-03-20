class AddTotalMalesAndTotalFemalesToDatasets < ActiveRecord::Migration[5.0]
  def change
    add_column :datasets, :total_subjects_male, :integer
    add_column :datasets, :total_subjects_female, :integer
  end
end
