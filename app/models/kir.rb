class Kir < ApplicationRecord
  validates :indigo_id, uniqueness: true
  belongs_to :sample
  has_many :kir_genotype_wips
  has_paper_trail
  after_create :update_sample_kir_geno_flag
  after_update :update_sample_kir_geno_flag
  after_destroy :set_sample_kir_geno_flag_to_false

  def self.to_csv
    CSV.generate do |csv|
      cols = %w(indigo_id)
      csv << cols
      all.each do |record|
        csv << record.attributes.values_at(*cols)
      end
    end
  end

  def update_sample_kir_geno_flag
    if !self.sample.kir_geno
      self.sample.update_attributes(kir_geno:true)
    end
  end

  def set_sample_kir_geno_flag_to_false
    self.sample.update_attributes(kir_geno:false)
  end
end
