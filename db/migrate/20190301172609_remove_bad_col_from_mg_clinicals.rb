class RemoveBadColFromMgClinicals < ActiveRecord::Migration[5.0]
  def change
    remove_column :mg_clinicals, :histological_dx
  end
end
