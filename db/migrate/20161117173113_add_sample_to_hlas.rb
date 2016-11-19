class AddSampleToHlas < ActiveRecord::Migration[5.0]
  def change
    add_reference :hlas, :sample, foreign_key: true
  end
end
