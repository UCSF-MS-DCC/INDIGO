class Gwas < ApplicationRecord
  has_many :gwas_samples
  has_many :samples, through: :gwas_samples
  has_many :batch_gwa
  has_many :batches, through: :batch_gwa
end
