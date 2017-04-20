class Topic < ApplicationRecord
  has_many :tags
  has_many :notes, through: :tags

  validates_presence_of :name
  validates_uniqueness_of :name
end
