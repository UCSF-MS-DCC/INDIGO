class AddCaseAndControlCountByGenderToDatasets < ActiveRecord::Migration[5.0]
  def change
    add_column :datasets, :cases_male, :integer
    add_column :datasets, :cases_female, :integer
    add_column :datasets, :controls_male, :integer
    add_column :datasets, :controls_female, :integer
  end
end
