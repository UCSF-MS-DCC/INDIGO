class AddDiseaseToCollaborators < ActiveRecord::Migration[5.0]
  def change
    add_column :collaborators, :disease, :string
  end
end
