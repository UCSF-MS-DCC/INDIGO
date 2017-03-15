class Dataset < ApplicationRecord
  belongs_to :collaborator
  has_many :batches
end
