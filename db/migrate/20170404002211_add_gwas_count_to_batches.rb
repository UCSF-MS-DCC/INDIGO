class AddGwasCountToBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :batches, :gwas_samples_count, :integer
  end
end
