class HaplotypeFrequency < ApplicationRecord
  scope :drb_dqb_dpb, -> { where("allele1 like ? AND allele2 like ? AND allele3 like ?", "DRB1%", "DQB1%", "DPB1%") }
end
