class CreateKirs < ActiveRecord::Migration[5.0]
  def change
    create_table :kirs do |t|
      t.string :indigo_id
      t.string :i2dl1
      t.string :x2dl1_2
      t.string :i2dl2_2
      t.string :x2dl2_2
      t.string :i2dl3
      t.string :x2dl3_2
      t.string :i2dl4
      t.string :x2dl4_2
      t.string :i2dl5a
      t.string :i2dl5a_2
      t.string :i2dl5b
      t.string :i2dl5b_2
      t.string :i2dp1
      t.string :x2dp1_2
      t.string :i2ds1
      t.string :x2ds1_2
      t.string :i2ds2
      t.string :x2ds2_2
      t.string :i2ds3
      t.string :x2ds3_2
      t.string :i2ds4
      t.string :x2ds4_2
      t.string :i2ds5
      t.string :x2ds5_2
      t.string :i3dl1
      t.string :x3dl1_2
      t.string :i3dl2
      t.string :x3dl2_2
      t.string :i3dl3
      t.string :x3dl3_2
      t.string :i3dp1
      t.string :x3dp1_2
      t.string :i3ds1
      t.string :x3ds1_2

      t.timestamps
    end
  end
end
