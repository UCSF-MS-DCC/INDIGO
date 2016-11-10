class CreateKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :keys do |t|
      t.string :keyfile

      t.timestamps
    end
  end
end
