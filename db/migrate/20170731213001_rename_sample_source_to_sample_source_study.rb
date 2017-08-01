class RenameSampleSourceToSampleSourceStudy < ActiveRecord::Migration[5.0]
  def change
    rename_column :samples, :sample_source, :sample_source_study
  end
end
