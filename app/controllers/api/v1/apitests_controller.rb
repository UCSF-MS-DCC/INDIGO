class Api::V1::ApitestsController < ApplicationController
  def jsonsamples
    @site = params[:site]
    @gender = params[:gender]
    @disease = params[:disease]
    @sample = Sample.where(gender: @gender).select(:ethnicity)
    render json: @sample

  end
end
