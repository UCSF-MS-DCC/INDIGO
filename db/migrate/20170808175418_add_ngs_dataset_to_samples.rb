class AddNgsDatasetToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :ngs_dataset, :string
  end
end
