class AddNotesToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :notes, :text
    add_column :samples, :exclude, :boolean
  end
end
