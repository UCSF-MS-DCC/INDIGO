class AddTotalSamplesSentToStanfordToDatasets < ActiveRecord::Migration[5.0]
  def change
    add_column :datasets, :total_samples_sent_to_stanford, :integer
  end
end
