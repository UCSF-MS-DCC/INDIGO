class IDR < ApplicationRecord
  has_one :sample

  def self.to_csv
    CSV.generate do |csv|
      cols = %w(indigo_id disease received_date sent_date batch gender ethnicity race site drb1_15_copies_calculated drb1_1 drb1_2 dqb1_1 dqb1_2 dpb1_1 dpb1_2 a_1 a_2 b_1 b_2 c_1 c_2)
      csv << cols
      all.each do |record|
        csv << record.attributes.values_at(*cols)
      end
    end
  end

end
