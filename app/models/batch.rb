class Batch < ApplicationRecord
  belongs_to :dataset
  has_many :samples
  before_validation :set_defaults, on: :create

  def set_defaults
    self.hlas_available = 0
    self.kirs_available = 0
  end
end
