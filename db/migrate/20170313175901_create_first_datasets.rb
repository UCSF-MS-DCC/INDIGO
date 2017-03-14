class CreateFirstDatasets < ActiveRecord::Migration[5.0]
  def change
    create_table :first_datasets do |t|


      t.timestamps
    end
  end
end
