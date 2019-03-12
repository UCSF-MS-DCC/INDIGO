class CollaboratorStatusDatatable
  delegate :params, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Collaborator.count,
      iTotalDisplayRecords: collaborators.total_entries,
      aaData:data
    }
  end

  private

    def data
      collaborators.map do |c|

       arr = [
          c.name,
          c.disease,
          c.expected_discovery,
          c.samples.count,
          c.samples.where("gender is not null or race is not null or ethnicity is not null or age_of_onset is not null or disease is not null").count,
          c.samples.where.not(date_to_stanford:nil).where.not(date_to_stanford:"not sent yet").count,
          c.samples.where(hla_geno:true).where(disease:["HC", "Not MS - Unaffected - Unrelated - Spouse"]).count,
          c.samples.where(hla_geno:true).where.not(disease:["HC", "Not MS - Unaffected - Unrelated - Spouse"]).count,
          c.samples.where(kir_raw:true).count,
          c.samples.where(kir_geno:true).where(disease:["HC", "Not MS - Unaffected - Unrelated - Spouse"]).count,
          c.samples.where(kir_geno:true).where.not(disease:["HC", "Not MS - Unaffected - Unrelated - Spouse"]).count

        ]
        arr
      end
    end

    def collaborators
      @collaborators ||= fetch_collaborators
    end

    def fetch_collaborators
      collaborators = Collaborator.where.not(disease:"SCZD").order("#{sort_column} #{sort_direction}")
      collaborators = collaborators.paginate(:page => page, :per_page => per_page)
      collaborators
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
