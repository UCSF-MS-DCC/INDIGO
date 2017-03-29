class AddNewOptionsToBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :batches, :samples_unknown_disease_male, :integer
    add_column :batches, :samples_unknown_disease_female, :integer
    add_column :batches, :samples_unknown_disease_unknown_gender, :integer
    add_column :batches, :hlas_unknown_disease_male, :integer
    add_column :batches, :hlas_unknown_disease_female, :integer
    add_column :batches, :hlas_unknown_disease_unknown_gender, :integer
    add_column :batches, :kirs_unknown_disease_male, :integer
    add_column :batches, :kirs_unknown_disease_female, :integer
    add_column :batches, :kirs_unknown_disease_unknown_gender, :integer
  end
end
