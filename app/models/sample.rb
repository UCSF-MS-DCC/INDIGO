class Sample < ApplicationRecord
  validates :indigo_id, uniqueness: true

  def self.to_csv
    CSV.generate do |csv|
      cols = %w(indigo_id site_sample_id disease received_date sent_date batch sex ethnicity site)
      csv << cols
      all.each do |record|
        csv << record.attributes.values_at(*cols)
      end
    end
  end
end
