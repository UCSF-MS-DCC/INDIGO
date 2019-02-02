class AddMogIggAndNotesToNmoClinicals < ActiveRecord::Migration[5.0]
  def change
    add_column :nmo_clinicals, :anti_mog_igg_ab, :string
    add_column :nmo_clinicals, :notes, :text
  end
end
