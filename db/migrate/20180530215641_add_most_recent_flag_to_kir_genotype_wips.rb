class AddMostRecentFlagToKirGenotypeWips < ActiveRecord::Migration[5.0]
  def change
    add_column :kir_genotype_wips, :most_recent, :boolean
  end
end
