class RenameThymectomyColInMgClinicals < ActiveRecord::Migration[5.0]
  def change
    rename_column :mg_clinicals, :thymectomy_new, :thymectomy
  end
end
