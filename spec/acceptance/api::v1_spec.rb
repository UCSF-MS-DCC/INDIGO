require 'rails_helper'
require 'spec_helper'
require 'rspec_api_documentation/dsl'

User.delete_all
user = User.new(email:"user@test.com", password:"321321321", password_confirmation:"321321321", affiliation:'UCSF', approved:'true')
user.save!


resource "indigo.ucsf.edu/api/v1/datafetch" do
  before do
    @user = User.find_by(email:"user@test.com")
    header "X-User-Email", @user.email
    header "X-User-Token", @user.authentication_token
  end
  get '/api/v1/datafetch' do
    example "Querying dataset with valid INDIGO credentials" do
      do_request
      status.should == 200
    end
  end
  get '/api/v1/datafetch?sex=F' do
    example "Querying dataset, filtered by sex" do
      do_request
      status.should == 200
    end
  end
  get '/api/v1/datafetch?disease=MS' do
    example "Querying dataset, filtered by disease" do
      do_request
      status.should == 200
    end
  end
  get '/api/v1/datafetch?minage=20' do
    example "Querying dataset, filtered by minimum age of onset" do
      do_request
      status.should == 200
    end
  end
  get '/api/v1/datafetch?maxage=80' do
    example "Querying dataset, filtered by maximum age of onset" do
      do_request
      status.should == 200
    end
  end
  get '/api/v1/datafetch?minage=20&maxage=80&sex=M&disease=MS' do
    example "Querying dataset, filtered by multiple parameters" do
      do_request
      status.should == 200
    end
  end
  get '/api/v1/datafetch?hla=true' do
    example "Querying dataset, hla flag set to true" do
      do_request
      fields = []
      body = JSON.parse(response_body)
      body.each do |k, v|
        fields.push(k)
      end
      fields.should == ["id", "sex", "disease", "age_of_onset", "ethnicity", "drb1_1","drb1_2","dqb1_1","dqb1_2", "dpb1_1","dpb1_2","a_1","a_2","b_1","b_2","c_1","c_2","dpa1_1","dpa1_2","dqa1_1","dqa1_2","drbo_1","drbo_2"]
    end
  end
end

resource "Credentials" do
  before do
    header "X-User-Email",""
    header "X-User-Token", ""
  end
  get '/api/v1/datafetch' do
    example "Redirect to sign up on request with missing credentials" do
      do_request
      status.should == 302
    end
  end
  before do
    header "X-User-Email", "user@test.com"
    header "X-User-Token", "abc123"
  end
  get '/api/v1/datafetch' do
    example "Redirect to sign up on request with bad credentials" do
      do_request
      status.should == 302
    end
  end
end
