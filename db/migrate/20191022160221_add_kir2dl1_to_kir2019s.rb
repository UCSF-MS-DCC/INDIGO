class AddKir2dl1ToKir2019s < ActiveRecord::Migration[5.0]
  def change
    add_column :kir2019s, :kir2dl1_1, :string
    add_column :kir2019s, :kir2dl1_2, :string
    add_column :kir2019s, :kir2dl1_status, :string
  end
end
