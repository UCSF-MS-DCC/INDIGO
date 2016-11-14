class DropKirs < ActiveRecord::Migration[5.0]
  def change
    drop_table :kirs
  end
end
