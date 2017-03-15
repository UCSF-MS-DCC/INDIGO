class AddExpectedDiscoveryAndDemographicToCollaborator < ActiveRecord::Migration[5.0]
  def change
    add_column :collaborators, :expected_discovery, :integer
    add_column :collaborators, :demographic, :string
  end
end
