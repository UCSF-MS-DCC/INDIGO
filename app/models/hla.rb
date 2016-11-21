class Hla < ApplicationRecord
  validates :indigo_id, uniqueness: true
  belongs_to :sample

  def self.to_csv
    CSV.generate do |csv|
      cols = %w(indigo_id drb1_15_copies_calculated drb1_1 drb1_2 dqb1_1 dqb1_2 dpb1_1 dpb1_2 a_1 a_2 b_1 b_2 c_1 c_2)
      csv << cols
      all.each do |record|
        csv << record.attributes.values_at(*cols)
      end
    end
  end
end