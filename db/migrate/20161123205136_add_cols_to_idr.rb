class AddColsToIDR < ActiveRecord::Migration[5.0]
  def change
    add_column :idrs, :indigo_id, :string
    add_column :idrs, :sample_source, :string
    add_column :idrs, :disease, :string
    add_column :idrs, :gender, :string
    add_column :idrs, :ethnicity, :string
    add_column :idrs, :batch, :string
    add_column :idrs, :age_at_sample, :integer
    add_column :idrs, :race, :string
    add_column :idrs, :received_date, :string
    add_column :idrs, :sent_date, :string
    add_column :idrs, :drb1_15_copies_calculated, :string
    add_column :idrs, :drb1_1, :string
    add_column :idrs, :drb1_2, :string
    add_column :idrs, :dqb1_1, :string
    add_column :idrs, :dqb1_2, :string
    add_column :idrs, :dpb1_1, :string
    add_column :idrs, :dpb1_2, :string
    add_column :idrs, :a_1, :string
    add_column :idrs, :a_2, :string
    add_column :idrs, :b_1, :string
    add_column :idrs, :b_2, :string
    add_column :idrs, :c_1, :string
    add_column :idrs, :c_2, :string
    add_column :idrs, :dpa1_1, :string
    add_column :idrs, :dpa1_2, :string
    add_column :idrs, :dqa1_1, :string
    add_column :idrs, :dqa1_2, :string
    add_column :idrs, :drbo_1, :string
    add_column :idrs, :drbo_2, :string
  end
end
