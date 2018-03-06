class AddFrequencyToAlleleFrequencies < ActiveRecord::Migration[5.0]
  def change
    add_column :allele_frequencies, :frequency, :decimal, :precision => 4, :scale => 3
  end
end
