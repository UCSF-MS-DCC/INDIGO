# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#user = User.create(email: 'adamrenschen@gmail.com', password: '321321', password_confirmation: '321321', affiliation: 'UCSF', approved:true, sent_approved_email:true)
#user.add_role "admin"



#KirGenotypeWip.create({"status": "pending incorporation with results from other methods", "method": "PING_haplocaller", "kir_extracted_directory": "/home/common_arse/INDIGO/2_KIR_runs_extracted/indigo_plates1-4_extracted_8-5-17/", "genotype": "KIR3DL1*002+KIR3DL1*0040101", "raw_data_directory": "/home/common_arse/INDIGO/1_INDIGO_plates1-4_KIR_runs/INDIGO_1/IND00001-30675053/Data/Intensities/BaseCalls/", "output_directory": "/home/common_arse/INDIGO/3_PING_output/ping_haplo_validation/", "method_version": "v1.0", "batch": "ping_haplo_validation", "locus": "3DL1"})
#KirGenotypeWip.create({"status": "pending incorporation with results from other methods", "method": "PING", "kir_extracted_directory": "/home/common_arse/INDIGO/2_KIR_runs_extracted/indigo_plates1-4_extracted_8-5-17/", "genotype": "KIR3DL1*00401+KIR3DL1*002", "raw_data_directory": "/home/common_arse/INDIGO/1_INDIGO_plates1-4_KIR_runs/INDIGO_1/IND00001-30675053/Data/Intensities/BaseCalls/", "output_directory": "/home/common_arse/INDIGO/3_PING_output/indigo_plates1-4_Results_8-5-17/caller_results_9-26-17/KIRcaller/", "method_version": "v1.0", "batch": "indigo_plates1-4", "locus": "3DL1"})

# sites = [Faker::StarWars.specie, Faker::StarWars.specie, Faker::StarWars.specie]
# sites.each do |site_name|
#   Collaborator.create(name:site_name, location:Faker::StarWars.planet)
# end
# x = 1
# 2000.times do
#   id = "INDIGO_TEST_SAMPLE_#{x}"
#   study_no = Faker::Number.between(0,2)
#
#   @sample = Sample.new(indigo_id:id,
#                        sample_source_study: sites[study_no],
#                        sample_source_identifier: "#{sites[study_no]}_Sample_#{x}",
#                        received_date: Faker::Date.between(4.years.ago, 3.years.ago),
#                        disease:["HC", "HC", "HC", "MS", "PD", "MG", "NMO"][Faker::Number.between(0,6)],
#                        gender:["F","M"][Faker::Number.between(0,1)],
#                        age_at_sample:Faker::Number.between(25,70),
#                        age_of_onset:Faker::Number.between(18,55),
#                        date_to_stanford:Faker::Date.between(3.years.ago, Date.today),
#                        race:["white", "african american", "asian", "native"][Faker::Number.between(0,3)],
#                        collaborator_id:study_no
#                        )
#   @sample.build_hla(indigo_id:id,
#                    drb1_1:"DRB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    drb1_2:"DRB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    dqb1_1:"DQB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    dqb1_2:"DQB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    dpb1_1:"DPB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    dpb1_2:"DPB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    a_1:"A*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    a_2:"A*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    b_1:"B*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    b_2:"B*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    c_1:"C*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    c_2:"C*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    dpa1_1:"DPA1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    dpa1_2:"DPA1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    dqa1_1:"DQA1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    dqa1_2:"DQA1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    drbo_1:"DRB4*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
#                    drbo_2:"DRB3*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}")
#
#    @sample.build_kir(indigo_id:id,
#                    KIR3DL2:"KIR3DL2*00#{Faker::Number.between(1,9)}",
#                      KIR2DS5:"KIR2DS5*00#{Faker::Number.between(1,9)}",
#                      KIR2DL4:"KIR2DL4*00#{Faker::Number.between(1,9)}",
#                      KIR3DL1:"KIR3DL1*00#{Faker::Number.between(1,9)}",
#                      KIR3DS1:"KIR3DS1*00#{Faker::Number.between(1,9)}",
#                      KIR2DL1:"KIR2DL1*00#{Faker::Number.between(1,9)}",
#                      KIR2DL2:"KIR2DL2*00#{Faker::Number.between(1,9)}",
#                      KIR2DL3:"KIR2DL3*00#{Faker::Number.between(1,9)}",
#                      KIR2DL5A:"KIR2DL5A*00#{Faker::Number.between(1,9)}",
#                      KIR2DL5B:"KIR2DL5B*00#{Faker::Number.between(1,9)}",
#                      KIR2DS1:"KIR2DS1*00#{Faker::Number.between(1,9)}",
#                      KIR2DS2:"KIR2DS2*00#{Faker::Number.between(1,9)}",
#                      KIR2DS3:"KIR2DS3*00#{Faker::Number.between(1,9)}",
#                      KIR2DS4:"KIR2DS4*00#{Faker::Number.between(1,9)}",
#                      KIR2DP1:"KIR2DP1*00#{Faker::Number.between(1,9)}",
#                      KIR3DL3:"KIR3DL3*00#{Faker::Number.between(1,9)}",
#                      raw_data_at_ucsf:true
#                      )
#   @sample.save
#   x += 1
# end
samples = Sample.all.limit(10)
locus = "KIR2DL1"
method_versions = [Faker::Date.between(5.years.ago,4.years.ago),Faker::Date.between(4.years.ago,3.years.ago),Faker::Date.between(3.years.ago,2.years.ago)]

samples.each do |sample|
  method_versions.each do |v|
    KirGenotypeWip.create(sample_id:sample.id,method_version:v,method:"PING",genotype:"#{locus}*#{Faker::Number.between(100,999)}",locus:locus, output_directory:"-", raw_data_directory:"-",kir_extracted_directory:"-")
  end
end
