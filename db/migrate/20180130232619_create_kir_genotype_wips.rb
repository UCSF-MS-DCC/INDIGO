class CreateKirGenotypeWips < ActiveRecord::Migration[5.0]
  def change
    create_table :kir_genotype_wips do |t|
      t.references :kir, foreign_key: true
      t.string :locus
      t.string :status
      t.text :output_directory
      t.text :kir_extracted_directory
      t.text :raw_data_directory
      t.string :batch
      t.string :method
      t.string :method_version

      t.timestamps
    end
  end
end
