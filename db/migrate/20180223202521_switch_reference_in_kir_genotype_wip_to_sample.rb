class SwitchReferenceInKirGenotypeWipToSample < ActiveRecord::Migration[5.0]
  def change
    remove_reference :kir_genotype_wips, :kir, index: true
    add_reference :kir_genotype_wips, :sample, index: true
  end
end
