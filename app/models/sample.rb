class Sample < ApplicationRecord
  validates :indigo_id, uniqueness: true
end
