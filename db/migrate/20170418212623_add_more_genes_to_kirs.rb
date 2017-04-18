class AddMoreGenesToKirs < ActiveRecord::Migration[5.0]
  def change
    add_column :kirs, :KIR2DL1, :text
    add_column :kirs, :KIR2DL2, :text
    add_column :kirs, :KIR2DL3, :text
    add_column :kirs, :KIR2DL5A, :text
    add_column :kirs, :KIR2DL5B, :text
    add_column :kirs, :KIR2DS1, :text
    add_column :kirs, :KIR2DS2, :text
    add_column :kirs, :KIR2DS3, :text
    add_column :kirs, :KIR2DS4, :text
    add_column :kirs, :KIR2DP1, :text
    add_column :kirs, :KIR3DL3, :text
  end
end
