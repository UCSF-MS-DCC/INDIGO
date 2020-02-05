class AddAgeOnsetRangeToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :aao_range, :string
  end
end
