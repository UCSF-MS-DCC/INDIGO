class Api::V1::ApitestsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!

  def jsonsamples
    @site = params[:site]
    @gender = params[:gender]
    @disease = params[:disease]
    @age = params[:age_at_sample]
    @idr = IDR.where(age_at_sample: @age)
    render json: @idr

  end
end
