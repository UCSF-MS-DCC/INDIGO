class RenameKirGenoColInSamples < ActiveRecord::Migration[5.0]
  def change
    rename_column :samples, :kir_geno, :pre_2019_kir_geno
  end
end
