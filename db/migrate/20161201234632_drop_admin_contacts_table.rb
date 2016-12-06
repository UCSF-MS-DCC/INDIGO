class DropAdminContactsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :admin_contacts
  end
end
