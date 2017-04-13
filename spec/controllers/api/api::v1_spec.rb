require 'rails_helper'

RSpec.describe Api::V1Controller, type: :request do
  User.delete_all
  user = User.new(email:"user@test.com", password:"321321321", password_confirmation:"321321321", affiliation:'UCSF', approved:'true')
  user.save!

  describe "GET #datafetch" do
    it "returns status 200 with valid credentials" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('200')
    end

    it "should redirect to user sign in with invalid credentials" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch', headers: { "X-User-Token" => @user.email, "X-User-Email" => @user.authentication_token }

      expect(response).to redirect_to('/users/sign_in')
    end

    it "should return a response with content-type: JSON" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response.content_type).to eq("application/json")
    end

    it "should return a valid JSON object" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect {JSON.parse(response.body)}.to_not raise_error
    end

    it "should return status 200 on requests with valid query string sex parameters" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?sex=F', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('200')
    end

    it "should return status 422 - Unprocessable Entity on requests with invalid query string sex parameters" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?sex=Female', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('422')
    end

    it "should return status 200 - Ok on requests with valid query string disease parameters" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?disease=MS', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('200')
    end

    it "should return status 200 - Ok on requests with downcased query string disease parameters" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?disease=ms', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('200')
    end

    it "should return status 422 - Unprocessable Entity on requests with invalid query string disease parameters" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?disease=MultipleSclerosis', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('422')
    end

    it "should return status 200 - Ok on requests with valid query string minimum age parameters" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?minage=25', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('200')
    end

    it "should return status 422 - Unprocessable Entity on requests with invalid query string minimum age parameters" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?minage=Twentyfive', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('422')
    end

    it "should return status 200 - Ok on requests with valid query string maximum age parameters" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?maxage=95', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('200')
    end

    it "should return status 422 - Unprocessable Entity on requests with invalid query string maximum age parameters" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?maxage=Ninetyfive', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('422')
    end

    it "should return status 200 - ok on requests with a valid query string hla flag" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?hla=true', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('200')
    end

    it "should return status 422 - Unprocessable Entity on requests with invalid query string hla flag" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?hla=all', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('422')
    end

    it "should return status 200 - Ok on requests with multiple valid query string parameters" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?hla=true&sex=F&disease=MS', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('200')
    end

    it "should return status 422 - Unprocessable Entity on requests with multiple query string parameters where one parameter is invalid" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?hla=true&sex=F&disease=multiplesclerosis', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      expect(response).to have_http_status('422')
    end

    it "should return a json object with keys for id, sex, ethnicity, disease, and age of onset" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      body = JSON.parse(response.body)

      expect(body.keys).to contain_exactly("id", "sex", "ethnicity", "disease", "age_of_onset")
    end

    it "should return a json object with additional keys for hla genes when the hla parameter is set to true" do
      @user = User.find_by(email:"user@test.com")

      get '/api/v1/datafetch?hla=t', headers: { "X-User-Token" => @user.authentication_token, "X-User-Email" => @user.email }

      body = JSON.parse(response.body)

      expect(body.keys).to contain_exactly("id", "sex", "ethnicity", "disease", "age_of_onset", "drb1_1","drb1_2","dqb1_1","dqb1_2", "dpb1_1","dpb1_2","a_1","a_2","b_1","b_2","c_1","c_2","dpa1_1","dpa1_2","dqa1_1","dqa1_2","drbo_1","drbo_2")
    end

  end

end
