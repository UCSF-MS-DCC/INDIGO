# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'adamrenschen@gmail.com', password: '321321', password_confirmation: '321321', affiliation: 'UCSF', approved:true, sent_approved_email:true)
user.add_role "admin"



#KirGenotypeWip.create({"status": "pending incorporation with results from other methods", "method": "PING_haplocaller", "kir_extracted_directory": "/home/common_arse/INDIGO/2_KIR_runs_extracted/indigo_plates1-4_extracted_8-5-17/", "genotype": "KIR3DL1*002+KIR3DL1*0040101", "raw_data_directory": "/home/common_arse/INDIGO/1_INDIGO_plates1-4_KIR_runs/INDIGO_1/IND00001-30675053/Data/Intensities/BaseCalls/", "output_directory": "/home/common_arse/INDIGO/3_PING_output/ping_haplo_validation/", "method_version": "v1.0", "batch": "ping_haplo_validation", "locus": "3DL1"})
#KirGenotypeWip.create({"status": "pending incorporation with results from other methods", "method": "PING", "kir_extracted_directory": "/home/common_arse/INDIGO/2_KIR_runs_extracted/indigo_plates1-4_extracted_8-5-17/", "genotype": "KIR3DL1*00401+KIR3DL1*002", "raw_data_directory": "/home/common_arse/INDIGO/1_INDIGO_plates1-4_KIR_runs/INDIGO_1/IND00001-30675053/Data/Intensities/BaseCalls/", "output_directory": "/home/common_arse/INDIGO/3_PING_output/indigo_plates1-4_Results_8-5-17/caller_results_9-26-17/KIRcaller/", "method_version": "v1.0", "batch": "indigo_plates1-4", "locus": "3DL1"})

