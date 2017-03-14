class CreateDatasets < ActiveRecord::Migration[5.0]
  def change
    create_table :datasets do |t|
      t.string :source
      t.integer :expected_discovery
      t.string :disease

      t.timestamps
    end
  end
end
