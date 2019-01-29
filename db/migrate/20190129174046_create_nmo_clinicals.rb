class CreateNmoClinicals < ActiveRecord::Migration[5.0]
  def change
    create_table :nmo_clinicals do |t|
      t.references :sample, foreign_key: true
      t.string :anti_aqp4_antibodies

      t.timestamps
    end
  end
end
