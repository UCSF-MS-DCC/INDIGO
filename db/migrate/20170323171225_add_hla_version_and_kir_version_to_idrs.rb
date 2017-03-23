class AddHlaVersionAndKirVersionToIdrs < ActiveRecord::Migration[5.0]
  def change
    add_column :idrs, :hla_version, :string
    add_column :idrs, :kir_version, :string
  end
end
