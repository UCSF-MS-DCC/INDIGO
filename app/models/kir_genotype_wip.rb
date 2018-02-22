class KirGenotypeWip < ApplicationRecord
  has_paper_trail

  belongs_to :sample
end
