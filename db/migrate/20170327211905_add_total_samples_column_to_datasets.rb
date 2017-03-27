class AddTotalSamplesColumnToDatasets < ActiveRecord::Migration[5.0]
  def change
    add_column :datasets, :total_samples, :integer
  end
end
