class AddSentApprovedEmailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sent_approved_email, :boolean
  end
end
