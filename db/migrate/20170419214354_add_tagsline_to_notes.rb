class AddTagslineToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :tagsline, :string
  end
end
