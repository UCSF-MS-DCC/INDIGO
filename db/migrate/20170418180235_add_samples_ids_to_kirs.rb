class AddSamplesIdsToKirs < ActiveRecord::Migration[5.0]
  def change
    add_column :kirs, :sample_id, :integer
  end
end
