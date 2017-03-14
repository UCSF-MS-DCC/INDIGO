class AlterBatchesModelToFitDatasetBatchSampleChain < ActiveRecord::Migration[5.0]
  def change
    add_reference :batches, :dataset, index:true
    add_foreign_key :batches, :datasets
  end
end
