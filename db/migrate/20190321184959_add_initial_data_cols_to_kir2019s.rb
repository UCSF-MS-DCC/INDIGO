class AddInitialDataColsToKir2019s < ActiveRecord::Migration[5.0]
  def change
    add_column :kir2019s, :indigo_id, :string
    add_column :kir2019s, :kir2dl4_1, :string
    add_column :kir2019s, :kir2dl4_2, :string
    add_column :kir2019s, :kir2dl4_status, :string
    add_column :kir2019s, :kir2dl23_1, :string
    add_column :kir2019s, :kir2dl23_2, :string
    add_column :kir2019s, :kir2dl23_status, :string
    add_column :kir2019s, :kir3dl1s1_1, :string
    add_column :kir2019s, :kir3dl1s1_2, :string
    add_column :kir2019s, :kir3dl1s1_status, :string
    add_column :kir2019s, :kir3dl2_1, :string
    add_column :kir2019s, :kir3dl2_2, :string
    add_column :kir2019s, :kir3dl2_status, :string
    add_column :kir2019s, :kir3dl3_1, :string
    add_column :kir2019s, :kir3dl3_2, :string
    add_column :kir2019s, :kir3dl3_status, :string
  end
end
