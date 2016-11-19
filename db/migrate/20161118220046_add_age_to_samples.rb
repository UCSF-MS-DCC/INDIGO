class AddAgeToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :age_at_sample, :integer
  end
end
