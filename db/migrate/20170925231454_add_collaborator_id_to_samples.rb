class AddCollaboratorIdToSamples < ActiveRecord::Migration[5.0]
  def change
    add_reference :samples, :collaborator, index:true
  end
end
