class RenameSiteToSampleSourceInSamples < ActiveRecord::Migration[5.0]
  def change
    rename_column :samples, :site, :sample_source
  end
end
