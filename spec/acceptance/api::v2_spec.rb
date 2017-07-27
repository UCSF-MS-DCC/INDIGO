require 'rails_helper'
require 'spec_helper'
require 'rspec_api_documentation/dsl'

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

  end # close resource do block
end
