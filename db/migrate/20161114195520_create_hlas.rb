class CreateHlas < ActiveRecord::Migration[5.0]
  def change
    create_table :hlas do |t|
      t.string :indigo_id
      t.string :drb1_15_copies_calculated
      t.string :drb1_1
      t.string :drb1_2
      t.string :dqb1_1
      t.string :dqb1_2
      t.string :dpb1_1
      t.string :dpb1_2
      t.string :a_1
      t.string :a_2
      t.string :b_1
      t.string :b_2
      t.string :c_1
      t.string :c_2

      t.timestamps
    end
  end
end
