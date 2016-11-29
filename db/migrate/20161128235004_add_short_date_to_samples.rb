class AddShortDateToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :short_date, :string
  end
end
