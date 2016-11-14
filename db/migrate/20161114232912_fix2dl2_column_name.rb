class Fix2dl2ColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :kirs, :i2dl2_2, :i2dl2
  end
end
