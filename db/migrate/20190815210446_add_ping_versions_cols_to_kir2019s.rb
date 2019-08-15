class AddPingVersionsColsToKir2019s < ActiveRecord::Migration[5.0]
  def change
    add_column :kir2019s, :v_ping_kir3dl1s1, :string
    add_column :kir2019s, :v_ping_kir2dl23, :string
    add_column :kir2019s, :v_ping_kir3dl3, :string
    add_column :kir2019s, :v_ping_kir2ds35, :string
    add_column :kir2019s, :v_ping_kir2dl5, :string
    add_column :kir2019s, :v_ping_kir2dl4, :string
    add_column :kir2019s, :v_ping_kir2dl1, :string
    add_column :kir2019s, :v_ping_kir2ds4, :string
  end
end
