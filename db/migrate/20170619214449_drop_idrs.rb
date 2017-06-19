class DropIdrs < ActiveRecord::Migration[5.0]
  def change
    drop_table :idrs
  end
end
