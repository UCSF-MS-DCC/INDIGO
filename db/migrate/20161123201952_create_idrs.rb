class CreateIdrs < ActiveRecord::Migration[5.0]
  def change
    create_table :idrs do |t|

      t.timestamps
    end
  end
end
