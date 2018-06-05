module Api::V2Helper

  def apply_query_filters(samples, params)
    @models = samples
    valid_diagnoses = Sample.all.pluck(:disease).uniq
    valid_sexes = Sample.all.pluck(:gender).uniq
    valid_sources = Collaborator.all.pluck(:name).uniq

    if params[:diagnosis] != nil && @models
      if valid_diagnoses.include? params[:diagnosis].upcase
        if params[:controls] && params[:controls].upcase == "T"
          @models = @models.where(disease:[params[:diagnosis].upcase, "HC"])
        else
          @models = @models.where(disease:params[:diagnosis].upcase)
        end
      end
    end

    if params[:sex] != nil && @models
      if valid_sexes.include? params[:sex].upcase
        @models = @models.where(gender:params[:sex].upcase)
      end
    end

    if params[:source] != nil && @models
      if valid_sources.include? params[:source]
        @models = @models.where(collaborator_id:Collaborator.find_by(name:params[:source]).id)
      end
    end

    @models

  end

end