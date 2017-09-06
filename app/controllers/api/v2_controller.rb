class Api::V2Controller < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
  load_and_authorize_resource :sample
  load_and_authorize_resource :hla, through: :sample
  load_and_authorize_resource :kir, through: :sample

  # helper method to determine what samples the user has access to and if the user can access data from other institutions
  def determine_source(user, requested_source)
    requested_source = requested_source.gsub(/[^a-zA-Z]/,"").downcase
    source_key = {"ucsf" => "UCSF", "mjff" => "MJ Fox Foundation", "nih" => "NIH", "besta" => "Besta Institute", "oslo" => "Oslo University Hospital"}
    if !user
      return "none"
    elsif !user.is_super?
      return user.affiliation
    elsif user.is_super? && !requested_source
      return false
    else
      return source_key[requested_source]
    end
  end

  def can_access_study(user, requested_study)
    requested_study = requested_study.gsub(/[^a-zA-Z]/,"").downcase
    study_key = {"ucsfmstrios" => "UCSF MS trios", "ucsfmsfamilies" => "UCSF MS families", "mjffbiofind" => "MJFF via Coriell BioFIND dataset", "mjffdatatop" => "MJFF via Indiana University DATATOP dataset", "ucsf" => "UCSF", "nihcoriell" => "ASingleton (NIH) via Coriell GWASdataset",
                  "nihneurox" => "ASingleton (NIH) via Coriell NeuroX dataset", "ucsfepic" => "UCSF EPIC cases", "oslo" => "HHarbo (University of Oslo) - MG dataset", "besta1" => "RMantegazza (Milan-Istituto Besta)-MG dataset",
                  "besta2" => "RMantegazza (Milan-Istituto Besta)-MG dataset2"}
    if !user
      return "none"
    elsif !user.is_super?
      sample = Sample.where(sample_source_study:study_key[requested_study]).first
      if sample.sample_source != user.affiliation || !sample
        return false
      else
        return study_key[requested_study]
      end
    else
      sample = Sample.where(sample_source_study:study_key[requested_study]).first
      if !sample || !study_key[requested_study]
        return false
      else
        return study_key[requested_study]
      end
    end
  end

  def sample
    # Todo: filtering on ages is problematic because some models have age_of_onset, some have age_at_sample. maybe have maxageonset and maxagesample for query params
    # Todo: need a way to access samples by source institution. currently the sample_source column in samples contains the dataset name (ie MJFF BioFIND)

    # identify the user
    @user = User.find_by(authentication_token: params[:user_token], email:params[:user_email])
    if !@user
      render json: {"error":"no such registered user"}, status: :forbidden
      return
    end

    search_params = {}

    query_params = {
      :disease => params[:diagnosis] ? params[:diagnosis].gsub(/[^a-zA-Z]/,"").upcase : false,
      :sample_source => params[:source] ? determine_source(@user, params[:source]) : false,
      :gender => params[:sex] && (params[:sex].downcase == "m" || params[:sex].downcase == "f") ? params[:sex].upcase : false,
      :sample_source_study => params[:study] ? can_access_study(@user, params[:study]) : false
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
    # Todo: filtering on ages is problematic because some models have age_of_onset, some have age_at_sample. maybe have maxageonset and maxagesample for query params
    # Todo: need a way to access samples by source institution. currently the sample_source column in samples contains the dataset name (ie MJFF BioFIND)

    # identify the user
    @user = User.find_by(authentication_token: params[:user_token], email:params[:user_email])
    if !@user
      render json: {"error":"no such registered user"}, status: :forbidden
      return
    end
    # helper method to determine what samples the user has access to and if the user can access data from other institutions
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
      :sample_source => params[:source] ? determine_source(@user, params[:source]) : false,
      :gender => params[:sex] && (params[:sex].downcase == "m" || params[:sex].downcase == "f") ? params[:sex].upcase : false,
      :sample_source_study => params[:study] ? can_access_study(@user, params[:study]) : false
    }

    #create a hash of params to use in the ActiveRecord query below
    query_params.each do |k, v|
      unless !v
        search_params[k.to_sym] = [v]
      end
    end
    # controls is not a sample model attribute name, but an accepted value for the sample.disease attribute, so including controls with the rendered data requires adding "HC" to the disease params
    controls = params[:controls] && (params[:controls].downcase == "true" || params[:controls].downcase == "t") ? true : false
    unless !controls
      if search_params[:disease]
        search_params[:disease].push("HC")
      else
        search_params[:disease] = ["HC"]
      end
    end

    #user can include a list of genes to return. If there is no genes specified, return gl strings for all loci
    loci = %w(a b c drb1 dqb1 dpb1 dpa1 dqa1 drbo)
    params_gene_list = params[:gene] ? params[:gene] : false
    genes = {"a":false, "b":false, "c":false, "dpa1":false, "dqa1":false, "drb1":false, "dqb1":false, "dpb1":false, "drbo":false}
    full_gene_list = true
    unless !params_gene_list
      full_gene_list = false
      params_gene_list.each do |locus|
        if loci.index(locus) != nil
          genes[locus] = true
        end
      end
    end


    hla_samples = Sample.where(search_params)

    if !full_gene_list
      render json: hla_samples, each_serializer: HlaSerializer, genelist:genes, status: :ok
    else
      render json: hla_samples, each_serializer: HlaSerializer, genelist:"all", status: :ok
    end


    # minage/maxage params is on hold until age_of_onset vs. age_at_sample issue is sorted
    # minage = params[:minage] && (Integer(params[:minage]) rescue false) ? params[:minage].to_i : false
    # maxage = params[:maxage] && (Integer(params[:maxage]) rescue false) ? params[:maxage].to_i : false

  end

  def kir
    # Todo: filtering on ages is problematic because some models have age_of_onset, some have age_at_sample. maybe have maxageonset and maxagesample for query params
    # Todo: need a way to access samples by source institution. currently the sample_source column in samples contains the dataset name (ie MJFF BioFIND)

    # identify the user
    @user = User.find_by(authentication_token: params[:user_token], email:params[:user_email])
    if !@user
      render json: {"error":"no such registered user"}, status: :forbidden
      return
    end
    # helper method to determine what samples the user has access to and if the user can access data from other institutions
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
      :sample_source => params[:source] ? determine_source(@user, params[:source]) : false,
      :gender => params[:sex] && (params[:sex].downcase == "m" || params[:sex].downcase == "f") ? params[:sex].upcase : false,
      :sample_source_study => params[:study] ? can_access_study(@user, params[:study]) : false
    }

    #create a hash of params to use in the ActiveRecord query below
    query_params.each do |k, v|
      unless !v
        search_params[k.to_sym] = [v]
      end
    end
    # controls is not a sample model attribute name, but an accepted value for the sample.disease attribute, so including controls with the rendered data requires adding "HC" to the disease params
    controls = params[:controls] && (params[:controls].downcase == "true" || params[:controls].downcase == "t") ? true : false
    unless !controls
      if search_params[:disease]
        search_params[:disease].push("HC")
      else
        search_params[:disease] = ["HC"]
      end
    end

    #user can include a list of genes to return. If there is no genes specified, return gl strings for all loci
    loci = %w(2dl1 2dl2 2dl3 2dl4 2dl5a 2dl5b 2dp1 2ds1 2ds2 2ds3 2ds4 2ds5 3dl1 3dl2 3dl3 3ds1)
    params_gene_list = params[:gene] ? params[:gene] : false
    genes = {}
    loci.each do |g|
      genekey = "kir_#{g.upcase}"
      genes[genekey] = false
    end
    full_gene_list = true
    unless !params_gene_list
      full_gene_list = false
      params_gene_list.each do |locus|
        if loci.index(locus) != nil
          locus = "kir_#{locus.upcase}"
          genes[locus] = true
        end
      end
    end
    kir_samples = Sample.where(search_params)

    if !full_gene_list
      render json: kir_samples, each_serializer: KirSerializer, genelist:genes, status: :ok
    else
      render json: kir_samples, each_serializer: KirSerializer, genelist:"all", status: :ok
    end


  end

  def raw_kir

    @user = User.find_by(authentication_token: params[:user_token], email:params[:user_email])
    if !@user
      render json: {"error":"no such registered user"}, status: :forbidden
      return
    end


    raw_kir_indigo_id = params[:sample]

    @sample = Sample.find_by(indigo_id:raw_kir_indigo_id)

    if @sample
      if @sample.kir_raw == false || @sample.kir_raw == nil
        @sample.update_attributes(kir_raw:true)
        render json: @sample, each_serializer: SampleSerializer, status: :accepted
      else
        render json: @sample, each_serializer: SampleSerializer, status: :not_modified
      end
    else
      render json: { "error":"no such sample" }, status: :not_found
    end



  end #close def raw_kir block

  private

    def api_params
    end

end
