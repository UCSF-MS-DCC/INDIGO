class AddSentToStanfordToBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :batches, :to_stanford, :boolean
  end
end
