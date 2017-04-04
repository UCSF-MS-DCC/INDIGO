class Batch < ApplicationRecord
  belongs_to :dataset
  has_many :samples
  has_many :batch_gwa
  has_many :gwas, through: :batch_gwa
  before_validation :set_defaults, on: :create

  def set_defaults
  end
end
