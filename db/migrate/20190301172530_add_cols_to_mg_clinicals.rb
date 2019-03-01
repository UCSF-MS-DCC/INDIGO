class AddColsToMgClinicals < ActiveRecord::Migration[5.0]
  def change
    add_column :mg_clinicals, :histological_dx_involuted_thymus, :string
    add_column :mg_clinicals, :histological_dx_hyperplasic_thymus, :string
    add_column :mg_clinicals, :histological_dx_thymoma, :string
    add_column :mg_clinicals, :mg_type, :string
  end
end
