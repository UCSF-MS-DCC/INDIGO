class AddRaceToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :race, :string
  end
end
