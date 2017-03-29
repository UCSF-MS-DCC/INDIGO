class RemoveSourceFromBatch < ActiveRecord::Migration[5.0]
  def change
    remove_column :batches, :source
  end
end
