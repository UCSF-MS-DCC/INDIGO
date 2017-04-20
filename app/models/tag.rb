class Tag < ApplicationRecord
  belongs_to :note
  belongs_to :topic

  validates_presence_of :topic_id
  validates_presence_of :note_id
end
