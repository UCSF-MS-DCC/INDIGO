class Dataset < ApplicationRecord
  validates_presence_of :source, :disease
  validates_uniqueness_of :source
end
