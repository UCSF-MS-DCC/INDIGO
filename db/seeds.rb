# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user = User.create(email: 'adamrenschen@gmail.com', password: '321321', password_confirmation: '321321', affiliation: 'UCSF', approved:true)
# user.update_attributes(:approved => true)
# user.add_role "admin"

kir = Kir.last

kir.kir_genotype_wips.create(status:"Incomplete", output_directory:Faker::Internet.url("sandypoint.ucsf.edu"), kir_extracted_directory:Faker::Internet.url("sandypoint.ucsf.edu"),
batch:"B02", method:"PING", method_version:"v5.0.1", locus:"2dl2")
kir.kir_genotype_wips.create(status:"Complete", output_directory:Faker::Internet.url("sandypoint.ucsf.edu"), kir_extracted_directory:Faker::Internet.url("sandypoint.ucsf.edu"),
batch:"B02", method:"Haplo", method_version:"v2.5.2", locus:"2dl2")
kir.kir_genotype_wips.create(status:"Pending", output_directory:Faker::Internet.url("sandypoint.ucsf.edu"), kir_extracted_directory:Faker::Internet.url("sandypoint.ucsf.edu"),
batch:"B02", method:"Probe", method_version:"v8.6.4", locus:"2dl2")
