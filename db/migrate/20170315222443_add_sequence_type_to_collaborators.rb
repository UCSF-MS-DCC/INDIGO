class AddSequenceTypeToCollaborators < ActiveRecord::Migration[5.0]
  def change
    add_column :collaborators, :sequence_type, :string
  end
end
