class Collaborator < ApplicationRecord
  has_many :datasets
  has_many :samples
end
