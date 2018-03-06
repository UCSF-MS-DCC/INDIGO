class CreateAlleleFrequencies < ActiveRecord::Migration[5.0]
  def change
    create_table :allele_frequencies do |t|
      t.string :locus
      t.string :genotype
      t.string :disease
      t.integer :n_of_cohort
      t.references :collaborator, foreign_key: true

      t.timestamps
    end
  end
end
