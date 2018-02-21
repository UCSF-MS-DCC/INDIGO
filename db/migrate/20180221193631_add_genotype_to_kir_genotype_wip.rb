class AddGenotypeToKirGenotypeWip < ActiveRecord::Migration[5.0]
  def change
    add_column :kir_genotype_wips, :genotype, :text
  end
end
