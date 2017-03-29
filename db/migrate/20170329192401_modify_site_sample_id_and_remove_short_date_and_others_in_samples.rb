class ModifySiteSampleIdAndRemoveShortDateAndOthersInSamples < ActiveRecord::Migration[5.0]
  def change
    rename_column :samples, :site_sample_id, :sample_source_identifier
    remove_column :samples, :short_date
    remove_column :samples, :batch
    remove_column :samples, :sent_date
    remove_column :samples, :idr_id
  end
end
