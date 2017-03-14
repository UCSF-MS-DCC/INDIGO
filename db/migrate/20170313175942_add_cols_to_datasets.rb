class AddColsToDatasets < ActiveRecord::Migration[5.0]
  def change
    add_column :first_datasets, :source, :string
    add_column :first_datasets, :disease, :string
    add_column :first_datasets, :samples_received_at_ucsf, :integer
    add_column :first_datasets, :samples_in_process_at_stanford, :integer
    add_column :first_datasets, :hlas_available, :integer
    add_column :first_datasets, :kirs_available, :integer
  end
end
