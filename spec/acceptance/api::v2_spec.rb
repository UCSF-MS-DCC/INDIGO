require 'rails_helper'
require 'spec_helper'
require 'rspec_api_documentation/dsl'
require 'set'

RSpec.describe Api::V2Controller, type: :request do
  User.delete_all
  user = User.new(email:"user@test.com", password:"321321321", password_confirmation:"321321321", affiliation:'UCSF', approved:'true')
  user.save!


  resource "API v2 sample endpoint" do
    before do
      @user = User.find_by(email:"user@test.com")
      header "X-User-Email", @user.email
      header "X-User-Token", @user.authentication_token

      dis = %w(MS HC)
      sex = %w(M F)
      tf = %w(T F)
      eth = %w(White Asian Black Hispanic)
      count = 1
      samsrc = "UCSF"
      samsrcidbase = "EPIC0"
      indidbase = "INDIGO00"

      3.times do
        Sample.new(sample_source:"UCSF", disease:dis[Faker::Number.between(0,1)], gender:sex[Faker::Number.between(0,1)], ethnicity:eth[Faker::Number.between(0,3)], sample_source:samsrc, sample_source_identifier:"#{samsrcidbase}#{Faker::Number.between(1,9)}",
                   age_of_onset:Faker::Number.between(20, 80), age_at_sample:Faker::Number.between(25,85), indigo_id:"#{indidbase}#{Faker::Number.between(1,9)}").save(validate:false)
      end
      3.times do
        Sample.new(sample_source:"NIH", disease:dis[Faker::Number.between(0,1)], gender:sex[Faker::Number.between(0,1)], ethnicity:eth[Faker::Number.between(0,3)], sample_source_identifier:"#NIH00#{Faker::Number.between(1,9)}",
                   age_of_onset:Faker::Number.between(20, 80), age_at_sample:Faker::Number.between(25,85), indigo_id:"#{indidbase}#{Faker::Number.between(1,9)}").save(validate:false)
      end
      3.times do
        Sample.new(sample_source:"NIA", disease:dis[Faker::Number.between(0,1)], gender:sex[Faker::Number.between(0,1)], ethnicity:eth[Faker::Number.between(0,3)], sample_source_identifier:"#NIA00#{Faker::Number.between(1,9)}",
                   age_of_onset:Faker::Number.between(20, 80), age_at_sample:Faker::Number.between(25,85), indigo_id:"#{indidbase}#{Faker::Number.between(1,9)}").save(validate:false)
      end
    end

    get '/api/v2/sample' do
      example "Querying dataset with valid INDIGO credentials" do
        do_request
        status.should == 200
      end
      example "Users only receive data for their own institution's samples" do
        do_request
        src_hist = {}
        body = JSON.parse(response_body)
        body.each do |hs|
          if src_hist[hs["sample_source"]]
            src_hist[hs["sample_source"]] += 1
          else
            src_hist[hs["sample_source"]] = 1
          end
        end
        src_hist["UCSF"].should == body.size
      end
      example "Superusers receive data for any/all institutions" do
        @user.add_role "superuser"
        do_request
        body = JSON.parse(response_body)
        body.size.should ==  9
      end
    end
    get '/api/v2/sample?diagnosis=MS' do
      example "Filtering by disease code" do
        do_request
        body = JSON.parse(response_body)
        dis_hist = {}
        body.each do |hs|
          if dis_hist[hs["disease"]]
            dis_hist[hs["disease"]] += 1
          else
            dis_hist[hs["disease"]] = 1
          end
        end
        dis_hist["MS"].should == body.size
      end
    end
    get '/api/v2/sample?source=UCSF' do
      example "Superusers filtering by sample source" do
        @user.add_role "superuser"
        do_request
        body = JSON.parse(response_body)
        src_hist = {}
        body.each do |hs|
          if src_hist[hs["sample_source"]]
            src_hist[hs["sample_source"]] += 1
          else
            src_hist[hs["sample_source"]] = 1
          end
        end
        src_hist["UCSF"].should == body.size
      end
    end

    get '/api/v2/sample?controls=t' do
      example "Include only controls in the response" do
        @user.add_role "superuser"
        do_request
        body = JSON.parse(response_body)
        count = 0
        body.each do |hs|
          if hs["disease"] == "HC" || hs["disease"] == "MS"
            count += 1
          end
        end
        count.should == body.size
      end
      example "Users should only get controls for their own institution" do
        do_request
        body = JSON.parse(response_body)
        src_hist = {}
        body.each do |hs|
          if src_hist[hs["sample_source"]]
            src_hist[hs["sample_source"]] += 1
          else
            src_hist[hs["sample_source"]] = 1
          end
        end
        src_hist["UCSF"].should == body.size
      end
    end

    get '/api/v2/sample?sex=f' do
      example "Filter API results by sex" do
        @user.add_role "superuser"
        do_request
        body = JSON.parse(response_body)
        count = 0
        body.each do |hs|
          if hs["gender"] == "F"
            count += 1
          end
        end
        count.should == body.size
      end
    end

    get '/api/v2/sample?sex=m&diagnosis=MS&controls=t&source=UCSF' do
      example "Filtering results by multiple parameters" do
        @user.add_role "superuser"
        do_request
        body = JSON.parse(response_body)
        count = 0
        body.each do |hs|
          if hs["gender"] == "M" && (hs["disease"] == "MS" || hs["disease"] == "HC") && hs["sample_source"] == "UCSF"
            count += 1
          end
        end
        count.should == body.size
      end
    end

  end # close resource API v2 sample endpoint do block

  resource "API v2 hla endpoint" do
    before do
      @user = User.find_by(email:"user@test.com")
      header "X-User-Email", @user.email
      header "X-User-Token", @user.authentication_token

      dis = %w(MS HC)
      sex = %w(M F)
      tf = %w(T F)
      eth = %w(White Asian Black Hispanic)
      count = 1
      samsrc = "UCSF"
      samsrcidbase = "EPIC0"
      indidbase = "INDIGO00"

      3.times do
        Sample.new(sample_source:"UCSF", disease:dis[Faker::Number.between(0,1)], gender:sex[Faker::Number.between(0,1)], ethnicity:eth[Faker::Number.between(0,3)], sample_source:samsrc, sample_source_identifier:"#{samsrcidbase}#{Faker::Number.between(1,9)}",
                   age_of_onset:Faker::Number.between(20, 80), age_at_sample:Faker::Number.between(25,85), indigo_id:"#{indidbase}#{Faker::Number.between(1,9)}").save(validate:false)
      end
      3.times do
        Sample.new(sample_source:"NIH", disease:dis[Faker::Number.between(0,1)], gender:sex[Faker::Number.between(0,1)], ethnicity:eth[Faker::Number.between(0,3)], sample_source_identifier:"#NIH00#{Faker::Number.between(1,9)}",
                   age_of_onset:Faker::Number.between(20, 80), age_at_sample:Faker::Number.between(25,85), indigo_id:"#{indidbase}#{Faker::Number.between(1,9)}").save(validate:false)
      end
      3.times do
        Sample.new(sample_source:"NIA", disease:dis[Faker::Number.between(0,1)], gender:sex[Faker::Number.between(0,1)], ethnicity:eth[Faker::Number.between(0,3)], sample_source_identifier:"#NIA00#{Faker::Number.between(1,9)}",
                   age_of_onset:Faker::Number.between(20, 80), age_at_sample:Faker::Number.between(25,85), indigo_id:"#{indidbase}#{Faker::Number.between(1,9)}").save(validate:false)
      end
      def gl_string
        "#{Faker::Number.between(0,1)}#{Faker::Number.between(1, 9)}:#{Faker::Number.between(0,5)}#{Faker::Number.between(1, 9)}:#{Faker::Number.between(0,1)}#{Faker::Number.between(1, 5)}"
      end
      Sample.all.each do |sample|
        Hla.new(sample_id:sample.id, indigo_id:sample.indigo_id, drb1_1:"DRB1*#{gl_string}", drb1_2:"DRB1*#{gl_string}", dqb1_1:"DQB*#{gl_string}", dqb1_2:"DQB*#{gl_string}", dpb1_1:"DPB*#{gl_string}", dpb1_2:"DPB1*#{gl_string}",
                a_1:"A*#{gl_string}", a_2:"A*#{gl_string}", b_1:"B*#{gl_string}", b_2:"B*#{gl_string}", c_1:"C*#{gl_string}", c_2:"C*#{gl_string}", dpa1_1:"DPA1*#{gl_string}", dpa1_2:"DPA1*#{gl_string}", dqa1_1:"DQA1*#{gl_string}",
                dqa1_2:"DQA1*#{gl_string}", drbo_1:"DRB3*#{gl_string}", drbo_2:"DRB3*#{gl_string}").save(validate:false)
      end
    end #close before do block

    get 'api/v2/hla' do
      example "Returns all sample phenotypes and hla gene loci" do
        fields = %w(sample_source disease gender ethnicity age_at_sample age_of_onset race a_1 a_2 b_1 b_2 c_1 c_2 dpa1_1 dpa1_2 drb1_1 drb1_2 dqb1_1 dqb1_2 dpb1_1 dpb1_2 dqa1_1 dqa1_2 drbo_1 drbo_2 indigo_id dpb1_phase_ambiguities).to_set
        do_request
        body = JSON.parse(response_body)
        body[0].keys.to_set.should == fields
      end
    end
    get 'api/v2/hla?gene[]=drb1&gene[]=dqb1&gene[]=dpa1' do
      example "Returns sample pheonotypes and gl strings for selected genes" do
        fields = %w(sample_source indigo_id disease gender ethnicity age_at_sample age_of_onset race drb1_1 drb1_2 dqb1_1 dqb1_2 dpa1_1 dpa1_2).to_set
        do_request
        body = JSON.parse(response_body)
        body[0].keys.to_set.should == fields
      end
    end
    get 'api/v2/hla?sex=f&source=UCSF' do
      example "Returns only data that meets all search criteria" do
        hist = {}
        do_request
        body=JSON.parse(response_body)
        body.each do |hs|
          if hist[hs["gender"]]
            hist[hs["gender"]] += 1
          else
            hist[hs["gender"]] = 1
          end
          if hist[hs["sample_source"]]
            hist[hs["sample_source"]] += 1
          else
            hist[hs["sample_source"]] = 1
          end
        end
        hist["F"].should == body.size
        hist["UCSF"].should == body.size
      end
    end
    get 'api/v2/hla?sex=m&source=UCSF&gene[]=a&gene[]=c' do
      example "Returns only data for selected criteria and returns genetic data for only specified loci" do
        fields = %w(sample_source indigo_id disease gender ethnicity age_at_sample age_of_onset race a_1 a_2 c_1 c_2).to_set
        hist = {}
        @user.add_role "superuser"
        do_request
        body = JSON.parse(response_body)
        body.each do |hs|
          if hist[hs["gender"]]
            hist[hs["gender"]] += 1
          else
            hist[hs["gender"]] = 1
          end
          if hist[hs["sample_source"]]
            hist[hs["sample_source"]] += 1
          else
            hist[hs["sample_source"]] = 1
          end
        end
        hist["M"].should == body.size
        hist["UCSF"].should == body.size
        body[0].keys.to_set.should == fields
      end
    end
    get 'api/v2/hla?gene[]=dpp&gene[]=dpb1&gene[]=drbo' do
      example "Returns data for valid loci names and no data for invalid loci names" do
        fields = %w(sample_source indigo_id disease gender ethnicity age_at_sample age_of_onset race dpb1_1 dpb1_2 drbo_1 drbo_2 dpb1_phase_ambiguities).to_set
        @user.add_role "superuser"
        do_request
        body = JSON.parse(response_body)
        body[0].keys.to_set.should == fields
      end
    end

  end #close resource API v2 hla endpoint block

  resource "API v2 kir endpoint" do
    before do
      @user = User.find_by(email:"user@test.com")
      header "X-User-Email", @user.email
      header "X-User-Token", @user.authentication_token

      dis = %w(MS HC)
      sex = %w(M F)
      tf = %w(T F)
      eth = %w(White Asian Black Hispanic)
      count = 1
      samsrc = "UCSF"
      samsrcidbase = "EPIC0"
      indidbase = "INDIGO00"

      3.times do
        Sample.new(sample_source:"UCSF", disease:dis[Faker::Number.between(0,1)], gender:sex[Faker::Number.between(0,1)], ethnicity:eth[Faker::Number.between(0,3)], sample_source:samsrc, sample_source_identifier:"#{samsrcidbase}#{Faker::Number.between(1,9)}",
                   age_of_onset:Faker::Number.between(20, 80), age_at_sample:Faker::Number.between(25,85), indigo_id:"#{indidbase}#{Faker::Number.between(1,9)}").save(validate:false)
      end
      3.times do
        Sample.new(sample_source:"NIH", disease:dis[Faker::Number.between(0,1)], gender:sex[Faker::Number.between(0,1)], ethnicity:eth[Faker::Number.between(0,3)], sample_source_identifier:"#NIH00#{Faker::Number.between(1,9)}",
                   age_of_onset:Faker::Number.between(20, 80), age_at_sample:Faker::Number.between(25,85), indigo_id:"#{indidbase}#{Faker::Number.between(1,9)}").save(validate:false)
      end
      3.times do
        Sample.new(sample_source:"NIA", disease:dis[Faker::Number.between(0,1)], gender:sex[Faker::Number.between(0,1)], ethnicity:eth[Faker::Number.between(0,3)], sample_source_identifier:"#NIA00#{Faker::Number.between(1,9)}",
                   age_of_onset:Faker::Number.between(20, 80), age_at_sample:Faker::Number.between(25,85), indigo_id:"#{indidbase}#{Faker::Number.between(1,9)}").save(validate:false)
      end
      def gl_string
        "0#{Faker::Number.between(0,1)}#{Faker::Number.between(1, 9)}#{Faker::Number.between(0,5)}#{Faker::Number.between(1, 9)}#{Faker::Number.between(0,1)}#{Faker::Number.between(1, 5)}"
      end
      Sample.all.each do |sample|
        Kir.new(sample_id:sample.id, indigo_id:sample.indigo_id, KIR2DL1:"KIR2DL1_#{gl_string}+KIR2DL1_#{gl_string}", KIR2DL2:"KIR2DL2_#{gl_string}+KIR2DL2_#{gl_string}", KIR2DL3:"KIR2DL3_#{gl_string}+KIR2DL3_#{gl_string}",
                KIR2DL4:"KIR2DL4_#{gl_string}+KIR2DL4_#{gl_string}", KIR2DL5A:"KIR2DL5A_#{gl_string}+KIR2DL5A_#{gl_string}", KIR2DL5B:"KIR2DL5B_#{gl_string}+KIR2DL5B_#{gl_string}", KIR2DP1:"KIR2DP1_#{gl_string}+KIR2DP1_#{gl_string}",
                KIR2DS1:"KIR2DS1_#{gl_string}+KIR2DS1_#{gl_string}", KIR2DS2:"KIR2DS2_#{gl_string}+KIR2DS2_#{gl_string}", KIR2DS3:"KIR2DS3_#{gl_string}+KIR2DS3_#{gl_string}", KIR2DS4:"KIR2DS4_#{gl_string}+KIR2DS4_#{gl_string}",
                KIR2DS5:"KIR2DS5_#{gl_string}+KIR2DS5_#{gl_string}", KIR3DL1:"KIR3DL1_#{gl_string}+KIR3DL1_#{gl_string}", KIR3DL2:"KIR3DL2_#{gl_string}+KIR3DL2_#{gl_string}", KIR3DL3:"KIR3DL3_#{gl_string}+KIR3DL3_#{gl_string}",
                KIR3DS1:"KIR3DS1_#{gl_string}+KIR3DS1_#{gl_string}").save(validate:false)
      end
    end #close before do block
    get 'api/v2/kir' do
      example "Returns all sample phenotypes and kir gene loci" do
        fields = %w(indigo_id sample_source disease gender ethnicity age_at_sample age_of_onset race KIR2DL1 KIR2DL2 KIR2DL3 KIR2DL4 KIR2DL5A KIR2DL5B KIR2DP1 KIR2DS1 KIR2DS2 KIR2DS3 KIR2DS4 KIR2DS5 KIR3DL1 KIR3DL2 KIR3DL3 KIR3DS1).to_set
        do_request
        body = JSON.parse(response_body)
        body[0].keys.to_set.should == fields
      end
    end
    get 'api/v2/kir?gene[]=2dl1&gene[]=2ds1&gene[]=3dl1' do
      example "Returns sample pheonotypes and gl strings for selected genes" do
        fields = %w(sample_source indigo_id disease gender ethnicity age_at_sample age_of_onset race KIR2DL1 KIR2DS1 KIR3DL1).to_set
        do_request
        body = JSON.parse(response_body)
        body[0].keys.to_set.should == fields
      end
    end
    get 'api/v2/kir?sex=f&source=UCSF' do
      example "Returns only data that meets all search criteria" do
        hist = {}
        do_request
        body=JSON.parse(response_body)
        body.each do |hs|
          if hist[hs["gender"]]
            hist[hs["gender"]] += 1
          else
            hist[hs["gender"]] = 1
          end
          if hist[hs["sample_source"]]
            hist[hs["sample_source"]] += 1
          else
            hist[hs["sample_source"]] = 1
          end
        end
        hist["F"].should == body.size
        hist["UCSF"].should == body.size
      end
    end
    get 'api/v2/kir?sex=m&source=UCSF&gene[]=3dl2&gene[]=3ds1&gene[]=2dl4&gene[]=2dp1' do
      example "Returns only data for selected criteria and returns genetic data for only specified loci" do
        fields = %w(sample_source indigo_id disease gender ethnicity age_at_sample age_of_onset race KIR3DL2 KIR3DS1 KIR2DL4 KIR2DP1).to_set
        hist = {}
        @user.add_role "superuser"
        do_request
        body = JSON.parse(response_body)
        body.each do |hs|
          if hist[hs["gender"]]
            hist[hs["gender"]] += 1
          else
            hist[hs["gender"]] = 1
          end
          if hist[hs["sample_source"]]
            hist[hs["sample_source"]] += 1
          else
            hist[hs["sample_source"]] = 1
          end
        end
        hist["M"].should == body.size
        hist["UCSF"].should == body.size
        body[0].keys.to_set.should == fields
      end
    end
    get 'api/v2/kir?gene[]=2dd5&gene[]=2dl3&gene[]=2dl5a&gene[]=2dl5b' do
      example "Returns data for valid loci names and no data for invalid loci names" do
        fields = %w(sample_source indigo_id disease gender ethnicity age_at_sample age_of_onset race KIR2DL3 KIR2DL5A KIR2DL5B).to_set
        @user.add_role "superuser"
        do_request
        body = JSON.parse(response_body)
        body[0].keys.to_set.should == fields
      end
    end
  end #closes resource API v2 kir endpoint block

  resource 'API v2 raw_kir endpoint' do

  end #closes resource API v2 raw_kir endpoint block
end
