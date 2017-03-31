class RefactorKirTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :kirs

    create_table :kirs do |t|
      t.string :indigo_id
      t.string :KIR3DL2
      t.string :KIR2DS5
      t.string :KIR2DL4

      t.timestamps
    end
  end
end

