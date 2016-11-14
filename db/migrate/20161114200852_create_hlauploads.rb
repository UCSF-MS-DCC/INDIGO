class CreateHlauploads < ActiveRecord::Migration[5.0]
  def change
    create_table :hlauploads do |t|
      t.string :datafile

      t.timestamps
    end
  end
end
