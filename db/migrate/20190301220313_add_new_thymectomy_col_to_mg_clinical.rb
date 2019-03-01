class AddNewThymectomyColToMgClinical < ActiveRecord::Migration[5.0]
  def change
    add_column :mg_clinicals, :thymectomy_new, :string
  end
end
