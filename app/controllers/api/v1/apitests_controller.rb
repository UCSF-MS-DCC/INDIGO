class Api::V1::ApitestsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!

  def jsonsamples
    @user = User.where(authentication_token: params[:user_token])
    @idr = IDR.where(sample_source: @user[0].affiliation).limit(10)
    if @idr.count == 0
      render json: {'message':'there is no data from your institution available'}
    else
      render json: @idr
    end
  end
end


AIzaSyBuJGruo-Du5OoRo6feKHC3csCRxHdOGDs
