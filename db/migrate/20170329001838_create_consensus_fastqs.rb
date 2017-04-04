class CreateConsensusFastqs < ActiveRecord::Migration[5.0]
  def change
    create_table :consensus_fastqs do |t|
      t.string :INDIGO_ID
      t.string :gene
      t.text :fastq

      t.timestamps
    end
  end
end
