class AddDpb1PhaseAmbiguitiesToIDRAndHla < ActiveRecord::Migration[5.0]
  def change
    add_column :idrs, :dpb1_phase_ambiguities, :string
    add_column :hlas, :dpb1_phase_ambiguities, :string
  end
end
