class CreateMgClinicals < ActiveRecord::Migration[5.0]
  def change
    create_table :mg_clinicals do |t|
      t.string :achr
      t.string :musk
      t.string :lrp4
      t.string :agrin
      t.string :titin
      t.string :netrin_1
      t.string :caspr2
      t.string :seronegative
      t.string :anti_ache
      t.string :steroid
      t.string :immunosuppresant
      t.string :biologicals
      t.string :last_obs_anti_ache
      t.string :last_obs_steroid
      t.string :last_obs_immunosuppressant
      t.string :last_obs_biologicals
      t.boolean :thymectomy
      t.string :histological_dx

      t.timestamps
    end
  end
end
