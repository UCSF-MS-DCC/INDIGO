class AddGenoFlagsToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :hla_geno, :boolean
    add_column :samples, :kir_geno, :boolean
    add_column :samples, :kir_raw, :boolean
  end
end
