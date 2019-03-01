class ChangeMgClinicalThymectomyToString < ActiveRecord::Migration[5.0]
  def change
    change_column :mg_clinicals, :thymectomy, :string
  end
end
