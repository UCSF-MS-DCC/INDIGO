class AlterHaplotypeFrequenciesScalePrecision < ActiveRecord::Migration[5.0]
  def change
    change_column :haplotype_frequencies, :frequency, :decimal, :precision => 6, :scale => 3
  end
end
