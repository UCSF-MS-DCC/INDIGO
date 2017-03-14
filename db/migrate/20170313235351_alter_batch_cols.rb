class AlterBatchCols < ActiveRecord::Migration[5.0]
  def change
    change_column :batches, :samples_received_at_ucsf, :string
    rename_column :batches, :samples_in_process_at_stanford, :samples_sent_to_stanford
    change_column :batches, :samples_sent_to_stanford, :string
    add_column :batches, :samples, :integer
  end
end
