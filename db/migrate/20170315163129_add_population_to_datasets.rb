class AddPopulationToDatasets < ActiveRecord::Migration[5.0]
  def change
    add_column :datasets, :population, :string
  end
end
