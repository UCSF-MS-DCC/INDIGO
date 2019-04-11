class AddKirGenoColToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :kir_geno, :boolean
  end
end
