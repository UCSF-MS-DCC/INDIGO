class AddSampleSourceToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :sample_source, :string
  end
end
