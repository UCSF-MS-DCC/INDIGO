class CreateBatchGwas < ActiveRecord::Migration[5.0]
  def change
    create_table :batch_gwas do |t|
      t.integer :batch_id
      t.integer :gwas_id

      t.timestamps
    end
  end
end
