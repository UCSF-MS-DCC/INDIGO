class Activity < ApplicationRecord
  validates :activity, :person, :date, presence: true

end
