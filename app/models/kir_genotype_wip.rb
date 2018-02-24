class KirGenotypeWip < ApplicationRecord
  has_paper_trail

  validates_presence_of :locus
  validates_presence_of :method

  belongs_to :sample
end
