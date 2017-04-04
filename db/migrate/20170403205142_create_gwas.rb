class CreateGwas < ActiveRecord::Migration[5.0]
  def change
    create_table :gwas do |t|

      t.timestamps
    end
  end
end
