class AddRefsToGwasSample < ActiveRecord::Migration[5.0]
  def change
    add_column :gwas_samples, :sample_id, :integer
    add_column :gwas_samples, :gwas_id, :integer
  end
end
