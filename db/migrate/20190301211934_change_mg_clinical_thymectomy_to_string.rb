class ChangeMgClinicalThymectomyToString < ActiveRecord::Migration[5.0]
  def change
    remove_column :mg_clinicals, :thymectomy
  end
end