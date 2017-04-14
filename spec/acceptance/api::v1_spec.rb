require 'rails_helper'
require 'spec_helper'
require 'rspec_api_documentation/dsl'

User.delete_all
user = User.new(email:"user@test.com", password:"321321321", password_confirmation:"321321321", affiliation:'UCSF', approved:'true')
user.save!

resource "R Studio data frame compatible JSON format: indigo.ucsf.edu/api/v1/rstudiodata" do
  before do
    @user = User.find_by(email:"user@test.com")
    header "X-User-Email", @user.email
    header "X-User-Token", @user.authentication_token
  end
  get '/api/v1/rstudiodata' do
    example "Querying dataset with valid INDIGO credentials" do
      do_request
      status.should == 200
    end
  end
  get '/api/v1/rstudiodata?sex=F' do
    example "Querying dataset, filtered by sex" do
      explanation "Adding sex= or sex= to the query string filters results by sex. Acceptable values are F or M. Only one sex= may be added to the query string. To receive data for all sexes, omit the sex= parameter."
      do_request
      status.should == 200
    end
  end
  get '/api/v1/rstudiodata?disease=MS' do
    example "Querying dataset, filtered by disease" do
      explanation "Adding disease= to the query string filters results by disease/control. Acceptable values are HC (control), MS (multiple sclerosis), MG (myasthenia gravis), or PD (Parkinson's disease). Only one disease= may be added to the query string.
      To receive both Controls and Cases, omit the disease= parameter."
      do_request
      status.should == 200
    end
  end
  get '/api/v1/rstudiodata?minage=20' do
    example "Querying dataset, filtered by minimum age of onset" do
      explanation "Adding minage= to the query string filters results by minimum age of onset. Acceptable values are any whole number (eg. 25). Do not use word values (eg. twentyfive)."
      do_request
      status.should == 200
    end
  end
  get '/api/v1/rstudiodata?maxage=30' do
    example "Querying dataset, filtered by maximum age of onset" do
      explanation "Adding maxage= to the query string filters results by maximum age of onset. Acceptable values are any whole number (eg. 25). Do not use word values (eg. twentyfive)."
      do_request
      status.should == 200
    end
  end
  get '/api/v1/rstudiodata?sex=M&disease=MS&hla=true' do
    example "Querying dataset, filtered by multiple parameters" do
      do_request
      status.should == 200
    end
  end
  get '/api/v1/rstudiodata?hla=true' do
    example "Querying dataset to retrieve HLA data" do
      explanation "Setting the hla= parameter to true will return all available hla gl strings for your institution's samples. Acceptable values are true or false. Omitting the hla= parameter or setting its value to false will result in no hla data being returned. "
      do_request
      fields = []
      body = JSON.parse(response_body)
      body.each do |k, v|
        fields.push(k)
      end
      fields.should == ["indigo_id", "id", "sex", "disease", "age_of_onset", "ethnicity", "drb1_1","drb1_2","dqb1_1","dqb1_2", "dpb1_1","dpb1_2","a_1","a_2","b_1","b_2","c_1","c_2","dpa1_1","dpa1_2","dqa1_1","dqa1_2","drbo_1","drbo_2"]
    end
  end
end

resource "Standard JSON format: indigo.ucsf.edu/api/v1/jsondata" do
  before do
    @user = User.find_by(email:"user@test.com")
    header "X-User-Email", @user.email
    header "X-User-Token", @user.authentication_token
  end
  get '/api/v1/jsondata' do
    example "Querying dataset with valid INDIGO credentials" do
      do_request
      status.should == 200
    end
  end
  get '/api/v1/jsondata?sex=F' do
    example "Querying dataset, filtered by sex" do
      explanation "Adding sex= or sex= to the query string filters results by sex. Acceptable values are F or M. Only one sex= may be added to the query string. To receive data for all sexes, omit the sex= parameter."
      do_request
      status.should == 200
    end
  end
  get '/api/v1/jsondata?disease=MS' do
    example "Querying dataset, filtered by disease" do
      explanation "Adding disease= to the query string filters results by disease/control. Acceptable values are HC (control), MS (multiple sclerosis), MG (myasthenia gravis), or PD (Parkinson's disease). Only one disease= may be added to the query string.
      To receive both Controls and Cases, omit the disease= parameter."
      do_request
      status.should == 200
    end
  end
  get '/api/v1/jsondata?minage=20' do
    example "Querying dataset, filtered by minimum age of onset" do
      explanation "Adding minage= to the query string filters results by minimum age of onset. Acceptable values are any whole number (eg. 25). Do not use word values (eg. twentyfive)."
      do_request
      status.should == 200
    end
  end
  get '/api/v1/jsondata?maxage=30' do
    example "Querying dataset, filtered by maximum age of onset" do
      explanation "Adding maxage= to the query string filters results by maximum age of onset. Acceptable values are any whole number (eg. 25). Do not use word values (eg. twentyfive)."
      do_request
      status.should == 200
    end
  end
  get '/api/v1/jsondata?sex=M&disease=MS&hla=true' do
    example "Querying dataset, filtered by multiple parameters" do
      do_request
      status.should == 200
    end
  end
  get '/api/v1/jsondata?hla=true' do
    example "Querying dataset to retrieve HLA data" do
      explanation "Setting the hla= parameter to true will return all available hla gl strings for your institution's samples. Acceptable values are true or false. Omitting the hla= parameter or setting its value to false will result in no hla data being returned. "
      do_request
      fields = []
      body = JSON.parse(response_body)[0]
      body.each do |k, v|
        fields.push(k)
      end
      fields.should == ["indigo_id", "id", "sex", "disease", "age_of_onset", "ethnicity", "drb1_1","drb1_2","dqb1_1","dqb1_2", "dpb1_1","dpb1_2","a_1","a_2","b_1","b_2","c_1","c_2","dpa1_1","dpa1_2","dqa1_1","dqa1_2","drbo_1","drbo_2"]
    end
  end
end

resource "Credentials" do
  before do
    header "X-User-Email",""
    header "X-User-Token", ""
  end
  get '/api/v1/jsondata' do
    example "Redirect to sign up on request with missing credentials" do
      do_request
      status.should == 302
    end
  end
  before do
    header "X-User-Email", "user@test.com"
    header "X-User-Token", "abc123"
  end
  get '/api/v1/jsondata' do
    example "Redirect to sign up on request with bad credentials" do
      do_request
      status.should == 302
    end
  end
end
