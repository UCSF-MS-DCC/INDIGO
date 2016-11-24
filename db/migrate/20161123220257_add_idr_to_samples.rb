class AddIDRToSamples < ActiveRecord::Migration[5.0]
  def change
    add_reference :samples, :idr, foreign_key: true
  end
end
