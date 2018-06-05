class DropKirGenotypeWipDefaultValueForMostRecentCol < ActiveRecord::Migration[5.0]
  def change
    change_column :kir_genotype_wips, :most_recent, :boolean
  end
end
