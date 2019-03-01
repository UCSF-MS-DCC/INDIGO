class AddSampleRefToMgClinicals < ActiveRecord::Migration[5.0]
  def change
    add_reference :mg_clinicals, :sample, foreign_key: true
  end
end
