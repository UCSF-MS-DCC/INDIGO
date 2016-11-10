class CreateSamples < ActiveRecord::Migration[5.0]
  def change
    create_table :samples do |t|
      t.string :site
      t.string :disease
      t.string :received_date
      t.string :indigo_id
      t.string :site_sample_id
      t.string :batch
      t.string :sent_date
      t.string :sex
      t.string :ethnicity

      t.timestamps
    end
  end
end
