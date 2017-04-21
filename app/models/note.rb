class Note < ApplicationRecord
  belongs_to :user
  has_many :tags
  has_many :topics, through: :tags

  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :user
end
