class Dataset < ApplicationRecord
  belongs_to :collaborator
  has_many :batches

  def self.say_hey
<<<<<<< HEAD
    puts "Hey"
=======
    puts "*************************HEY****************************"
>>>>>>> wheneverize
  end
end
