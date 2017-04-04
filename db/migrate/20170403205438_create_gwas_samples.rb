class CreateGwasSamples < ActiveRecord::Migration[5.0]
  def change
    create_table :gwas_samples do |t|

      t.timestamps
    end
  end
end
