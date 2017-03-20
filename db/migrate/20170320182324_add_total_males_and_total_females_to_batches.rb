class AddTotalMalesAndTotalFemalesToBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :batches, :male_subjects, :integer
    add_column :batches, :female_subjects, :integer
  end
end
