class ChangeColDefaultMostRecentInKirGenotypeWips < ActiveRecord::Migration[5.0]
  def change
    change_column :kir_genotype_wips, :most_recent, :boolean, :default => false
  end
end
