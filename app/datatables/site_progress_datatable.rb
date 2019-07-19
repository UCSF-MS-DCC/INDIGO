class SiteProgressDatatable
  delegate :params, :h, to: :@view

  def initialize(view, collaborator_id)
    @view = view
    @collaborator = Collaborator.find(collaborator_id) #valid id?
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Collaborator.count,
      iTotalDisplayRecords: data.size,# collaborators.total_entries,
      aaData:data
    }
  end

  private

    def data # may need more filtering here
      dates_in = samples.pluck(:received_date).uniq
      dates_out = samples.pluck(:date_to_stanford).uniq
      ngs = samples.pluck(:ngs_dataset).uniq

      records = []

      for date_in in dates_in
        for date_out in dates_out
          for ngs_value in ngs
            sams = Sample.where(received_date:date_in).where(date_to_stanford:date_out).where(ngs_dataset:ngs_value)
            samples_ids = sams.pluck(:id).uniq
            unless sams.size < 1
              row = [
                sams.pluck(:ngs_dataset).uniq,
                date_in, 
                date_out, 
                sams.where.not(disease:["HC", "Not MS - Unaffected - Unrelated - Spouse"]).count, 
                sams.where(disease:["HC", "Not MS - Unaffected - Unrelated - Spouse"]).count, 
                sams.count, 
                sams.where(hla_geno:true).count, 
                sams.where(kir_raw:true).count, 
                sams.where(kir_geno:true).count,
                sams.where(uploaded_to_immport:true).count,
                Hla.where(sample_id:samples_ids).where(uploaded_to_immport:true).count,
                Kir2019.where(sample_id:samples_ids).where(uploaded_to_immport:true).count
              ]
              records.push(row)
            end
          end
        end
      end
      records
    end

    def samples
      @samples ||= fetch_samples
    end

    def fetch_samples
      samples = Sample.where(collaborator_id:@collaborator.id)
      samples
    end

    def page
      params[:start].to_i/per_page + 1
    end

    def per_page
      params[:length].to_i > 0 ? params[:length].to_i : 100
    end

    def sort_column
      columns = %w(disease)
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:order]["0"]["dir"] == "desc" ? "desc" : "asc"
    end
end
