class Kir2019 < ApplicationRecord
  belongs_to :sample
  before_create :set_indigo_id
  after_create :update_sample_kir_geno_status

  private

  def set_indigo_id
    self.indigo_id = self.sample.indigo_id
  end

  def update_sample_kir_geno_status
    self.sample.update_kir_geno_status
  end
end
