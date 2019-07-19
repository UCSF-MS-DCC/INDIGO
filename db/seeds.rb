# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.new(email: 'adamrenschen@gmail.com', password: '321321', password_confirmation: '321321', affiliation: 'UCSF', approved:true, sent_approved_email:true).save(validate:false)
#
# # KirGenotypeWip.create({"status": "pending incorporation with results from other methods", "method": "PING_haplocaller", "kir_extracted_directory": "/home/common_arse/INDIGO/2_KIR_runs_extracted/indigo_plates1-4_extracted_8-5-17/", "genotype": "KIR3DL1*002+KIR3DL1*0040101", "raw_data_directory": "/home/common_arse/INDIGO/1_INDIGO_plates1-4_KIR_runs/INDIGO_1/IND00001-30675053/Data/Intensities/BaseCalls/", "output_directory": "/home/common_arse/INDIGO/3_PING_output/ping_haplo_validation/", "method_version": "v1.0", "batch": "ping_haplo_validation", "locus": "3DL1"})
# # KirGenotypeWip.create({"status": "pending incorporation with results from other methods", "method": "PING", "kir_extracted_directory": "/home/common_arse/INDIGO/2_KIR_runs_extracted/indigo_plates1-4_extracted_8-5-17/", "genotype": "KIR3DL1*00401+KIR3DL1*002", "raw_data_directory": "/home/common_arse/INDIGO/1_INDIGO_plates1-4_KIR_runs/INDIGO_1/IND00001-30675053/Data/Intensities/BaseCalls/", "output_directory": "/home/common_arse/INDIGO/3_PING_output/indigo_plates1-4_Results_8-5-17/caller_results_9-26-17/KIRcaller/", "method_version": "v1.0", "batch": "indigo_plates1-4", "locus": "3DL1"})
#
# sites = [Faker::Ancient.titan, Faker::Ancient.titan, Faker::StarWars.specie]
# 5.times do 
#   Collaborator.create(name:Faker::Ancient.titan, location:Faker::StarWars.planet, disease:["HC", "MS", "PD", "MG", "NMO", "ALS"][Faker::Number.between(0,5)],sequence_type:["HLA only", "KIR only", "HLA and KIR"][Faker::Number.between(0,2)])
# end
sample_immport_dates = [Faker::Date.between(6.months.ago, 18.months.ago), Faker::Date.between(3.months.ago,9.months.ago)]
hla_immport_dates = [Faker::Date.between(6.months.ago, 18.months.ago), Faker::Date.between(3.months.ago,9.months.ago)]
kir_immport_dates = [Faker::Date.between(6.months.ago, 18.months.ago), Faker::Date.between(3.months.ago,9.months.ago)]

received_dates  = [Faker::Date.between(2.years.ago, 18.months.ago), Faker::Date.between(2.years.ago,9.months.ago)]
sent_dates = = [Faker::Date.between(8.months.ago, 2.months.ago), Faker::Date.between(8.months.ago, 2.months.ago)]

1000.times do
  id = "INDIGO#{Faker::Number.between(10000,99999)}"
  @collaborator = Collaborator.all[Faker::Number.between(0,4)]
  ngs = @collaborator.sequence_type
  has_hla = (Faker::Number.between(1,8) >= 2 && ngs != "KIR only") ? true : false
  has_kir = (Faker::Number.between(1,8) >= 3 && ngs != "HLA only") ? true : false

  has_raw_kir = (has_kir == true && Faker::Number.between(1,10) > 2) ? true : false
  has_kir_geno = (has_raw_kir == true && Faker::Number.between(1,10) > 2) ? true : false

  @sample = Sample.new(indigo_id:id,
                       sample_source_study: @collaborator.name,
                       sample_source_identifier: "#{@collaborator.name}#{Faker::Number.between(100000,999999)}",
                       received_date: received_dates[Faker::Number.between(0,1)],
                       disease:["HC", "#{@collaborator.disease}","#{@collaborator.disease}"][Faker::Number.between(0,2)],
                       gender:["F","M"][Faker::Number.between(0,1)],
                       age_at_sample:Faker::Number.between(25,70),
                       age_of_onset:Faker::Number.between(18,55),
                       date_to_stanford:sent_dates[Faker::Number.between(0,1)],
                       race:["white", "african american", "asian", "native"][Faker::Number.between(0,3)],
                       collaborator_id:@collaborator.id,
                       ngs_dataset:ngs,
                       hla_geno:has_hla,
                       kir_raw:has_raw_kir,
                       kir_geno:has_kir_geno,
                       uploaded_to_immport:true,
                       immport_upload_date:sample_immport_dates[Faker::Number.between(0,1)]
                       )

  if has_hla
    @sample.hla.build(indigo_id:id,
                    drb1_1:"DRB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    drb1_2:"DRB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    dqb1_1:"DQB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    dqb1_2:"DQB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    dpb1_1:"DPB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    dpb1_2:"DPB1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    a_1:"A*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    a_2:"A*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    b_1:"B*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    b_2:"B*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    c_1:"C*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    c_2:"C*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    dpa1_1:"DPA1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    dpa1_2:"DPA1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    dqa1_1:"DQA1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    dqa1_2:"DQA1*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    drbo_1:"DRB4*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    drbo_2:"DRB3*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    drb345_1:"DRB#{Faker::Number.between(3,5)}*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    drb345_2:"DRB#{Faker::Number.between(3,5)}*#{Faker::Number.between(1,60)}:0#{Faker::Number.between(1,9)}",
                    uploaded_to_immport:true,
                    immport_upload_date:hla_immport_dates[Faker::Number.between(0,1)]
                    )

    end
    if has_kir_geno
      @sample.kir2019.build(indigo_id:id,
                    kir2dl4_1:"KIR2DL4*00#{Faker::Number.between(1,5)}#{Faker::Number.between(0,3)}#{Faker::Number.between(1,9)}",
                    kir2dl4_2:"KIR2DL4*00#{Faker::Number.between(1,5)}#{Faker::Number.between(0,3)}#{Faker::Number.between(1,9)}",
                    kir2dl4_status:"resolved",
                    kir2dl23_1:"KIR2DL23*00#{Faker::Number.between(1,5)}#{Faker::Number.between(0,3)}#{Faker::Number.between(1,9)}",
                    kir2dl23_2:"KIR2DL23*00#{Faker::Number.between(1,5)}#{Faker::Number.between(0,3)}#{Faker::Number.between(1,9)}",
                    kir2dl23_status:"resolved",
                    kir3dl1s1_1:"KIR3DL1*00#{Faker::Number.between(1,5)}#{Faker::Number.between(0,3)}#{Faker::Number.between(1,9)}",
                    kir3dl1s1_2:"KIR3DS1*00#{Faker::Number.between(1,5)}#{Faker::Number.between(0,3)}#{Faker::Number.between(1,9)}",
                    kir3dl1s1_status:"resolved",
                    kir3dl2_1:"KIR3DL2*00#{Faker::Number.between(1,5)}#{Faker::Number.between(0,3)}#{Faker::Number.between(1,9)}",
                    kir3dl2_2:"KIR3DL2*00#{Faker::Number.between(1,5)}#{Faker::Number.between(0,3)}#{Faker::Number.between(1,9)}",
                    kir3dl2_status:"resolved",
                    kir3dl3_1:"KIR3DL3*00#{Faker::Number.between(1,5)}#{Faker::Number.between(0,3)}#{Faker::Number.between(1,9)}",
                    kir3dl3_2:"KIR3DL3*00#{Faker::Number.between(1,5)}#{Faker::Number.between(0,3)}#{Faker::Number.between(1,9)}",
                    kir3dl3_status:"resolved",
                    uploaded_to_immport:true,
                    immport_upload_date:kir_immport_dates[Faker::Number.between(0,1)]
                    )
    end
  @sample.save(validate:false)

end

