class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.text :activity
      t.string :person
      t.string :date
      t.string :updated_by

      t.timestamps
    end
  end
end
