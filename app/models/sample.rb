class Sample < ApplicationRecord
  validates :indigo_id, uniqueness: true
  has_many :hla
  has_many :kir
  has_many :gwas_samples
  has_many :gwas, through: :gwas_samples
  belongs_to :batch

  def self.to_csv
    CSV.generate do |csv|
      cols = %w(indigo_id site_sample_id disease received_date sent_date batch sex ethnicity site)
      csv << cols
      all.each do |record|
        csv << record.attributes.values_at(*cols)
      end
    end
  end

  def self.to_csv_with_hla
    CSV.generate do |csv|
      sample_cols = %w(indigo_id sample_source_identifier disease gender ethnicity age_at_sample age_of_onset)
      hla_cols = %w(drb1_1 drb1_2 dqb1_1 dqb1_2 dpb1_1 dpb1_2 a_1 a_2 b_1 b_2 c_1 c_2 dpa1_1 dpa1_2 dqa1_1 dqa1_2 drbo_1 drbo_2)
      csv.add_row sample_cols + hla_cols
      all.each do |sample|
        values = sample.attributes.values_at(*sample_cols)
        if Hla.find_by(indigo_id:sample.indigo_id) != nil
          values += Hla.find_by(indigo_id:sample.indigo_id).attributes.values_at(*hla_cols)
        end
        csv.add_row values
      end
    end
  end

  def self.to_csv_with_kir
    CSV.generate do |csv|
      sample_cols = %w(indigo_id sample_source_identifier disease gender ethnicity age_at_sample age_of_onset)
      kir_cols = %w(KIR2DL1 KIR2DL2 KIR2DL3 KIR2DL4 KIR2DL5A KIR2DL5B KIR2DP1 KIR2DS1 KIR2DS2 KIR2DS3 KIR2DS4 KIR2DS5 KIR3DL1 KIR3DL2 KIR3DL3 KIR3DS1)
      csv.add_row sample_cols + kir_cols
      all.each do |sample|
        values = sample.attributes.values_at(*sample_cols)
        if Kir.find_by(indigo_id:sample.indigo_id) != nil
          values += Kir.find_by(indigo_id:sample.indigo_id).attributes.values_at(*kir_cols)
        end
        csv.add_row values
      end
    end
  end

end
