class CreateHaplotypeFrequencies < ActiveRecord::Migration[5.0]
  def change
    create_table :haplotype_frequencies do |t|
      t.string :allele1
      t.string :allele2
      t.string :allele3
      t.string :allele4
      t.string :allele5
      t.string :allele6
      t.decimal :frequency, precision: 3, scale: 3

      t.timestamps
    end
  end
end
