class AddSubjectAndBodyAndFromToAdminContact < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_contacts, :subject, :text
    add_column :admin_contacts, :body, :text
    add_column :admin_contacts, :from, :text
  end
end
