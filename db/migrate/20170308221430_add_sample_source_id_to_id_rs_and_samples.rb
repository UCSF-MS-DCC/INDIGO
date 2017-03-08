class AddSampleSourceIdToIdRsAndSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :idrs, :site_sample_id, :string
  end
end
