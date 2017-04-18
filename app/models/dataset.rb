class Dataset < ApplicationRecord
  belongs_to :collaborator
  has_many :batches

  def self.say_hey
    puts "Hey"
  end
end
