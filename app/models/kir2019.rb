class Kir2019 < ApplicationRecord
  belongs_to :sample
  before_create :set_indigo_id

  def set_indigo_id
    self.indigo_id = self.sample.indigo_id
  end
end
