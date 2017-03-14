class AddBatchesReferenceToSamples < ActiveRecord::Migration[5.0]
  def change
    add_reference :samples, :batch, foreign_key: true
  end
end
