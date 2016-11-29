class AddSampleIdToKirs < ActiveRecord::Migration[5.0]
  def change
    add_reference :kirs, :sample, foreign_key: true
  end
end
