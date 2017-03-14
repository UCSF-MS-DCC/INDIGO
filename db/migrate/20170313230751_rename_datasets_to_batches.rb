class RenameDatasetsToBatches < ActiveRecord::Migration[5.0]
  def change
    rename_table :first_datasets, :batches
  end
end
