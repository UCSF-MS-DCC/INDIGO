class DropDatasetsAndBatches < ActiveRecord::Migration[5.0]
  def change
    remove_index "batch_id", name:"index_samples_on_batch_id"
    remove_column :samples, :batch_id
    drop_table :batches
    drop_table :datasets

    drop_table :batch_gwas
  end
end
