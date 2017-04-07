class Api::V1::ApitestsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!

  def endpoint
    @user = User.find_by(authentication_token: params[:user_token], email:params[:user_email])
    sample_phenotypes = {sample_source: @user.affiliation}
    hla_genes = {}
    kir_genes = {}
    early_exit_flag = false

    #check params for allowable values
    sex = params[:gender]
    ethnicity = params[:ethnicity]
    disease = params[:disease]
    minage = params[:minage]
    maxage = params[:maxage]
    hla = params[:hla]
    kir = params[:kir]

    if sex != nil
      case sex
      when "F", "M"
        sample_phenotypes[:gender] = sex
      when "all", "All", "ALL"

      else
        if early_exit_flag == false
          early_exit_flag = true
          render json: {"error":"invalid query value for sex. Acceptable parameters are: F or M"}
        end
      end
    end

    if ethnicity != nil
      case ethnicity
      when "White-not Hispanic Origin"
        sample_phenotypes[:ethnicity] = ethnicity
      when "White-not Hispanic Origin, White-Hispanic Origin"
        sample_phenotypes[:ethnicity] = ethnicity
      when "White-not Hispanic Origin, Asian-Japanese"
        sample_phenotypes[:ethnicity] = ethnicity
      when "White-not Hispanic Origin, Asian-Chinese"
        sample_phenotypes[:ethnicity] = ethnicity
      when "Not Hispanic/Latino"
        sample_phenotypes[:ethnicity] = ethnicity
      when "Hispanic/Latino"
        sample_phenotypes[:ethnicity] = ethnicity
      when "All", "all", "ALL"
        #no action
      else
        if early_exit_flag == false
          early_exit_flag = true
          render json: {"error":"invalid query value for ethnicity. See site documentation for acceptable ethnicity parameters"}
        end
      end
    end

    if disease != nil
      case disease
      when "PD", "MG", "MS", "HC"
        sample_phenotypes[:disease] = disease
      else
        if early_exit_flag == false
          acceptable_diseases = Sample.where(sample_source:@user.affiliation).pluck(:disease).uniq
          early_exit_flag = true
          render json: {"error. invalid query value for disease. Acceptable parameters are": acceptable_diseases}
        end
      end
    end

    if minage != nil
      minagenum = minage.to_i
      case minagenum > 0
      when true
        minage = minagenum
      else
        if early_exit_flag == false
          early_exit_flag = true
          render json: {"error":"please enter a valid number for the minage parameter value"}
        end
      end
    end

    if maxage != nil
      maxagenum = maxage.to_i
      case maxagenum > 0
      when true
        maxage = maxagenum
      else
        if early_exit_flag == false
          early_exit_flag = true
          render json: {"error":"please enter a valid number for the maxage parameter value"}
        end
      end
    end

    #build the results for the api call based on user supplied parameters

    samples = Sample.where(sample_phenotypes).select("indigo_id, sample_source, gender, disease, age_of_onset")

    if minagenum
      samples = samples.where("age_of_onset >= ?", minagenum)
    end
    if maxagenum
      samples = samples.where("age_of_onset <= ?", maxagenum)
    end

    results = []

    samples.each do |s|
      hash = {
        indigo_id:s.indigo_id,
        sample_source: s.sample_source,
        gender: s.gender,
        disease: s.disease,
        age_of_onset: s.age_of_onset
      }
      results.push(hash)
    end
    puts results.first
    if hla == "true"
      results.each do |r|
        if Hla.where(indigo_id: r[:indigo_id]).count > 0
          @h = Hla.find_by(indigo_id: r[:indigo_id])
          r[:drb1_1] = @h[:drb1_1]
          r[:drb1_2] = @h[:drb1_2]
          r[:dqb1_1] = @h[:dqb1_1]
          r[:dqb1_2] = @h[:dqb1_2]
          r[:dpb1_1] = @h[:dpb1_1]
          r[:dpb1_2] = @h[:dpb1_2]
          r[:a_1] = @h[:a_1]
          r[:a_2] = @h[:a_2]
          r[:b_1] = @h[:b_1]
          r[:b_2] = @h[:b_2]
          r[:c_1] = @h[:c_1]
          r[:c_2] = @h[:c_2]
          r[:dpa1_1] = @h[:dpa1_1]
          r[:dpa1_2] = @h[:dpa1_2]
          r[:dqa1_1] = @h[:dqa1_1]
          r[:dqa1_2] = @h[:dqa1_2]
          r[:drbo_1] = @h[:drbo_1]
          r[:drbo_2] = @h[:drbo_2]
        else
          r[:drb1_1] = "-"
          r[:drb1_2] = "-"
          r[:dqb1_1] = "-"
          r[:dqb1_2] = "-"
          r[:dpb1_1] = "-"
          r[:dpb1_2] = "-"
          r[:a_1] = "-"
          r[:a_2] = "-"
          r[:b_1] = "-"
          r[:b_2] = "-"
          r[:c_1] = "-"
          r[:c_2] = "-"
          r[:dpa1_1] = "-"
          r[:dpa1_2] = "-"
          r[:dqa1_1] = "-"
          r[:dqa1_2] = "-"
          r[:drbo_1] = "-"
          r[:drbo_2] = "-"
        end
      end
    end

    if early_exit_flag == false
      render json: {"search parameters": params, "results": results}
    end
  end #close def endpoint block
end
