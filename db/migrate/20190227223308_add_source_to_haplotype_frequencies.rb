class AddSourceToHaplotypeFrequencies < ActiveRecord::Migration[5.0]
  def change
    add_column :haplotype_frequencies, :source, :string
    add_column :haplotype_frequencies, :pmid_ref, :string
    add_column :haplotype_frequencies, :race, :string
    add_column :haplotype_frequencies, :ethnicity, :string
    add_column :haplotype_frequencies, :disease, :string
    add_column :haplotype_frequencies, :total_n, :integer
  end
end
