require 'rails_helper'

RSpec.describe Api::V1Controller, type: :controller do

  describe "GET #datafetch" do
    context "with no query string" do
      get "/datafetch" do
        status.should == 200
      end
    end
  end

end
