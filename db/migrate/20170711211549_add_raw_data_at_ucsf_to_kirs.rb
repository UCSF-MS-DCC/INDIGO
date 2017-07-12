class AddRawDataAtUcsfToKirs < ActiveRecord::Migration[5.0]
  def change
    add_column :kirs, :raw_data_at_ucsf, :date
  end
end
