class AddCollaboratorReferenceToDatasets < ActiveRecord::Migration[5.0]
  def change
    add_reference :datasets, :collaborator, foreign_key: true
  end
end
