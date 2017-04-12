class Api::V1Controller < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!

  def endpoint
    @user = User.find_by(authentication_token: params[:user_token], email:params[:user_email])
    sample_phenotypes = {sample_source: @user.affiliation}
    hla_genes = {}
    kir_genes = {}
    early_exit_flag = false

    vars = request.query_parameters

    #check params for allowable values
    sex = params[:sex]
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
      render json: { "search parameters": vars, "results": results }
    end
  end #close def endpoint action block

  def datafetch
    @user = User.find_by(authentication_token: params[:user_token], email:params[:user_email])
    sample_phenotypes = {sample_source: @user.affiliation}
    hla_genes = {}
    kir_genes = {}
    early_exit_flag = false

    #store query string parameter values
    sex = params[:sex]
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

    samples = Sample.where(sample_phenotypes).select("indigo_id, sample_source_identifier, gender, disease, age_of_onset, ethnicity")


    #filter for minimum and/or maximum age of onset, if required

    if minagenum
      samples = samples.where("age_of_onset >= ?", minagenum)
    end
    if maxagenum
      samples = samples.where("age_of_onset <= ?", maxagenum)
    end
    #only return samples with HLA data
    hla_samples = []
    samples.each do |s|
      if Hla.where(indigo_id:s.indigo_id).count > 0
        hla_samples.push(s)
      end
    end


    results = { id: [], sex: [], disease:[], age_of_onset: [], ethnicity: [] }

    hla_samples.each do |s|
      if s.sample_source_identifier != nil
        results[:id].push(s.sample_source_identifier)
      else
        results[:id].push("NA")
      end
      if s.gender != nil
        results[:sex].push(s.gender)
      else
        results[:sex].push("NA")
      end
      if s.disease != nil
        results[:disease].push(s.disease)
      else
        results[:disease].push("NA")
      end
      if s.ethnicity != nil
        results[:ethnicity].push(s.ethnicity)
      else
        results[:ethnicity].push("NA")
      end
      if s.age_of_onset != nil
        results[:age_of_onset].push(s.age_of_onset)
      else
        results[:age_of_onset].push("NA")
      end
    end #close samples.each block

    if hla == "true"
      hla_hash = {
        drb1_1:[],
        drb1_2:[],
        dqb1_1:[],
        dqb1_2:[],
        dpb1_1:[],
        dpb1_2:[],
        a_1:[],
        a_2:[],
        b_1:[],
        b_2:[],
        c_1:[],
        c_2:[],
        dpa1_1:[],
        dpa1_2:[],
        dqa1_1:[],
        dqa1_2:[],
        drbo_1:[],
        drbo_2:[]
      }
      hla_samples.each do |s|
        if Hla.where(indigo_id:s.indigo_id).count > 0
          # still need to have a value in the return array if there is no hla gene for the sample. Push "NA" into all hla_hash fields
          @hla = Hla.find_by(indigo_id:s.indigo_id)
          if @hla[:drb1_1] == nil || @hla[:drb1_1] == "-"
            hla_hash[:drb1_1].push("NA")
          else
            hla_hash[:drb1_1].push(@hla[:drb1_1])
          end
          if @hla[:drb1_2] == nil || @hla[:drb1_2] == "-"
            hla_hash[:drb1_2].push("NA")
          else
            hla_hash[:drb1_2].push(@hla[:drb1_2])
          end
          if @hla[:dqb1_1] == nil || @hla[:dqb1_1] == "-"
            hla_hash[:dqb1_1].push("NA")
          else
            hla_hash[:dqb1_1].push(@hla[:dqb1_1])
          end
          if @hla[:dqb1_2] == nil || @hla[:dqb1_2] == "-"
            hla_hash[:dqb1_2].push("NA")
          else
            hla_hash[:dqb1_2].push(@hla[:dqb1_2])
          end
          if @hla[:dpb1_1] == nil || @hla[:dpb1_1] == "-"
            hla_hash[:dpb1_1].push("NA")
          else
            hla_hash[:dpb1_1].push(@hla[:dpb1_1])
          end
          if @hla[:dpb1_2] == nil || @hla[:dpb1_2] == "-"
            hla_hash[:dpb1_2].push("NA")
          else
            hla_hash[:dpb1_2].push(@hla[:dpb1_2])
          end
          if @hla[:a_1] == nil || @hla[:a_1] == "-"
            hla_hash[:a_1].push("NA")
          else
            hla_hash[:a_1].push(@hla[:a_1])
          end
          if @hla[:a_2] == nil || @hla[:a_2] == "-"
            hla_hash[:a_2].push("NA")
          else
            hla_hash[:a_2].push(@hla[:a_2])
          end
          if @hla[:b_1] == nil || @hla[:b_1] == "-"
            hla_hash[:b_1].push("NA")
          else
            hla_hash[:b_1].push(@hla[:b_1])
          end
          if @hla[:b_2] == nil || @hla[:b_2] == "-"
            hla_hash[:b_2].push("NA")
          else
            hla_hash[:b_2].push(@hla[:b_2])
          end
          if @hla[:c_1] == nil || @hla[:c_1] == "-"
            hla_hash[:c_1].push("NA")
          else
            hla_hash[:c_1].push(@hla[:c_1])
          end
          if @hla[:c_2] == nil || @hla[:c_2] == "-"
            hla_hash[:c_2].push("NA")
          else
            hla_hash[:c_2].push(@hla[:c_2])
          end
          if @hla[:dpa1_1] == nil || @hla[:dpa1_1] == "-"
            hla_hash[:dpa1_1].push("NA")
          else
            hla_hash[:dpa1_1].push(@hla[:dpa1_1])
          end
          if @hla[:dpa1_2] == nil || @hla[:dpa1_2] == "-"
            hla_hash[:dpa1_2].push("NA")
          else
            hla_hash[:dpa1_2].push(@hla[:dpa1_2])
          end
          if @hla[:dqa1_1] == nil || @hla[:dqa1_1] == '-'
            hla_hash[:dqa1_1].push("NA")
          else
            hla_hash[:dqa1_1].push(@hla[:dqa1_1])
          end
          if @hla[:dqa1_2] == nil || @hla[:dqa1_2] == "-"
            hla_hash[:dqa1_2].push("NA")
          else
            hla_hash[:dqa1_2].push(@hla[:dqa1_2])
          end
          if @hla[:drbo_1] == nil || @hla[:drbo_1] == "-"
            hla_hash[:drbo_1].push("NA")
          else
            hla_hash[:drbo_1].push(@hla[:drbo_1])
          end
          if @hla[:drbo_2] == nil || @hla[:drbo_2] == "-"
            hla_hash[:drbo_2].push("NA")
          else
            hla_hash[:drbo_2].push(@hla[:drbo_2])
          end
        else
          hla_hash[:drb1_1].push("NA")
          hla_hash[:drb1_2].push("NA")
          hla_hash[:dqb1_1].push("NA")
          hla_hash[:dqb1_2].push("NA")
          hla_hash[:dpb1_1].push("NA")
          hla_hash[:dpb1_2].push("NA")
          hla_hash[:a_1].push("NA")
          hla_hash[:a_2].push("NA")
          hla_hash[:b_1].push("NA")
          hla_hash[:b_2].push("NA")
          hla_hash[:c_1].push("NA")
          hla_hash[:c_2].push("NA")
          hla_hash[:dpa1_1].push("NA")
          hla_hash[:dpa1_2].push("NA")
          hla_hash[:dqa1_1].push("NA")
          hla_hash[:dqa1_2].push("NA")
          hla_hash[:drbo_1].push("NA")
          hla_hash[:drbo_2].push("NA")
        end #close if Hla.where(indigo_id:s.indigo_id)...  block
      end #close samples.each... block
      results = results.merge(hla_hash)
    end #close if hla == "true block"

    if early_exit_flag == false
      render json: results, status: :ok
    end
  end #close def datafetch action block
end
