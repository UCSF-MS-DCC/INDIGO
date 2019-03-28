class AddSampleIdToKir2019s < ActiveRecord::Migration[5.0]
  def change
    add_reference :kir2019s, :sample, foreign_key: true
  end
end
