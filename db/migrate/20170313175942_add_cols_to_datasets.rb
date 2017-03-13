class AddColsToDatasets < ActiveRecord::Migration[5.0]
  def change
    add_column :datasets, :source, :string
    add_column :datasets, :disease, :string
    add_column :datasets, :samples_received_at_ucsf, :integer
    add_column :datasets, :samples_in_process_at_stanford, :integer
    add_column :datasets, :hlas_available, :integer
    add_column :datasets, :kirs_available, :integer
  end
end
