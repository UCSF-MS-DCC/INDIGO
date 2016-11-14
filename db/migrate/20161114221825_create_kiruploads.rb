class CreateKiruploads < ActiveRecord::Migration[5.0]
  def change
    create_table :kiruploads do |t|
      t.string :datafile

      t.timestamps
    end
  end
end
