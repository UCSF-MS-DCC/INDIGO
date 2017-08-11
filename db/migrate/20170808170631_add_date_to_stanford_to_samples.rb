class AddDateToStanfordToSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :samples, :date_to_stanford, :string
  end
end
