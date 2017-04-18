class Add3dl1And3ds1ToKirs < ActiveRecord::Migration[5.0]
  def change
    add_column :kirs, :KIR3DL1, :text
    add_column :kirs, :KIR3DS1, :text
  end
end
