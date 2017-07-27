class Api::V2Controller < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
  load_and_authorize_resource :sample
  load_and_authorize_resource :hla, through: :sample
  load_and_authorize_resource :kir, through: :sample

  def sample
    # Todo: filtering on ages is problematic because some models have age_of_onset, some have age_at_sample. maybe have maxageonset and maxagesample for query params
    # Todo: need a way to access samples by source institution. currently the sample_source column in samples contains the dataset name (ie MJFF BioFIND)

    # identify the user
    @user = User.find_by(authentication_token: params[:user_token], email:params[:user_email])
    if !@user
      render json: {"error":"no such registered user"}, status: :forbidden
      return
    end

    # helper method to determine if user has access to a particular source's samples
    def determine_source(user, requested_source)
      if !user
        return "none"
      elsif !user.is_super?
        return user.affiliation
      elsif user.is_super? && !requested_source
        return false
      else
        return requested_source.gsub(/[^a-zA-Z]/,"")
      end
    end

    search_params = {}

    query_params = {
      :disease => params[:diagnosis] ? params[:diagnosis].gsub(/[^a-zA-Z]/,"").upcase : false,
      :sample_source => determine_source(@user, params[:source]),
      :gender => params[:sex] && (params[:sex].downcase == "m" || params[:sex].downcase == "f") ? params[:sex].upcase : false
    }
    # controls is not a sample model attribute name, but an accepted value for the sample.disease attribute, so including controls with the rendered data requires adding "HC" to the disease params
    controls = params[:controls] && (params[:controls].downcase == "true" || params[:controls].downcase == "t") ? true : false

    # minage/maxage params is on hold until age_of_onset vs. age_at_sample issue is sorted
    # minage = params[:minage] && (Integer(params[:minage]) rescue false) ? params[:minage].to_i : false
    # maxage = params[:maxage] && (Integer(params[:maxage]) rescue false) ? params[:maxage].to_i : false

    #create a hash of params to use in the ActiveRecord query below
    query_params.each do |k, v|
      unless !v
        search_params[k.to_sym] = [v]
      end
    end

    # if the user only wants controls, we will need to add in a search_params[:disease] key:value to the ActiveRecord search params
    unless !controls
      if search_params[:disease]
        search_params[:disease].push("HC")
      else
        search_params[:disease] = ["HC"]
      end
    end

    # query db for samples matching the search parameters
    samples = Sample.where(search_params)

    if samples.size > 0
      render json: samples, each_serializer:SampleSerializer, status: :ok
    else
      render json: {"message":"no samples available for this criteria"}, status: :not_found
    end


  end

  def hla
  end

  def kir
  end




end
