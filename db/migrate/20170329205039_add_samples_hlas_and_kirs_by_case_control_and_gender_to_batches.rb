class AddSamplesHlasAndKirsByCaseControlAndGenderToBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :batches, :samples_control_male, :integer
    add_column :batches, :samples_control_female, :integer
    add_column :batches, :samples_control_gender_unknown, :integer
    add_column :batches, :samples_case_male, :integer
    add_column :batches, :samples_case_female, :integer
    add_column :batches, :samples_case_gender_unknown, :integer
    add_column :batches, :hlas_control_male, :integer
    add_column :batches, :hlas_control_female, :integer
    add_column :batches, :hlas_control_gender_unknown, :integer
    add_column :batches, :hlas_case_male, :integer
    add_column :batches, :hlas_case_female, :integer
    add_column :batches, :hlas_case_gender_unknown, :integer
    add_column :batches, :kirs_case_male, :integer
    add_column :batches, :kirs_case_female, :integer
    add_column :batches, :kirs_case_gender_unknown, :integer
    add_column :batches, :kirs_control_male, :integer
    add_column :batches, :kirs_control_female, :integer
    add_column :batches, :kirs_control_gender_unknown, :integer
    rename_column :batches, :samples_received_at_ucsf, :date_received_from_source
    remove_column :batches, :hlas_available
    remove_column :batches, :kirs_available
    remove_column :batches, :cases
    remove_column :batches, :controls
    remove_column :batches, :male_subjects
    remove_column :batches, :female_subjects
  end
end
