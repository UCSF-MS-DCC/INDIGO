class DropKirGenotypeWipDefaultValueForMostRecentColAgain < ActiveRecord::Migration[5.0]
  def change
    change_column_default :kir_genotype_wips, :most_recent, nil
  end
end
