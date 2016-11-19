class Kir < ApplicationRecord
  validates :indigo_id, uniqueness: true
  belongs_to :sample

  def self.to_csv
    CSV.generate do |csv|
      cols = %w(indigo_id)
      csv << cols
      all.each do |record|
        csv << record.attributes.values_at(*cols)
      end
    end
  end
end
