class RenameSexToGenderInSamples < ActiveRecord::Migration[5.0]
  def change
    rename_column :samples, :sex, :gender
  end
end
