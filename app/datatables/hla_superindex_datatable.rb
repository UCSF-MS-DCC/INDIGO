class HlaSuperindexDatatable
  delegate :params, :h, to: :@view

  def initialize(view, disease)
    @view = view
    @disease = disease
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Hla.count,
      iTotalDisplayRecords: hlas.total_entries,
      aaData:data
    }
  end

  private

    def data
      hlas.map do |hla|

        [
          hla.indigo_id,
          hla.drb1_1,
          hla.drb1_2,
          hla.dqb1_1,
          hla.dqb1_2,
          hla.dpb1_1,
          hla.dpb1_2,
          hla.a_1,
          hla.a_2,
          hla.b_1,
          hla.b_2,
          hla.c_1,
          hla.c_2,
          hla.dpa1_1,
          hla.dpa1_2,
          hla.dqa1_1,
          hla.dqa1_2,
          hla.drbo_1,
          hla.drbo_2,
          hla.dpb1_phase_ambiguities
        ]
      end
    end

    def hlas
      @hlas ||= fetch_hlas
    end

    def fetch_hlas
      samples = Sample.where(disease:@disease).pluck(:id)
      hlas = Hla.where(sample_id:samples).order("#{sort_column} #{sort_direction}")
      hlas = hlas.paginate(:page => page, :per_page => per_page) #per_page == limit(value) page == offset
      if params[:search][:value].present?
        hlas = hlas.where("indigo_id like :search", search:"%#{params[:search][:value]}%")
      end
      hlas
    end

    def page
      params[:start].to_i/per_page + 1
    end

    def per_page
      params[:length].to_i > 0 ? params[:length].to_i : 100
    end

    def sort_column
      columns = %w(indigo_id)
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:order]["0"]["dir"] == "desc" ? "desc" : "asc"
    end
end
