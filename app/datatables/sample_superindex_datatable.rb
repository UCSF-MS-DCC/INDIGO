class SampleSuperindexDatatable
  delegate :params, :h, to: :@view

  def initialize(view, disease)
    @view = view
    @disease = disease

  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Sample.count,
      iTotalDisplayRecords: samples.total_entries,
      aaData:data
    }
  end

  private

    def data
      samples.map do |sample|

        [
          sample.indigo_id,
          "placeholder",
          sample.sample_source_study,
          sample.sample_source_identifier,
          sample.disease,
          sample.gender,
          sample.race,
          sample.age_of_onset,
          sample.age_at_sample
        ]
      end
    end

    def samples
      @samples ||= fetch_samples
    end

    def fetch_samples
      samples = Sample.where(disease:@disease).order("#{sort_column} #{sort_direction}")
      samples = samples.paginate(:page => page, :per_page => per_page) #per_page == limit(value) page == offset
      if params[:search][:value].present?
        samples = samples.where("sample_source like :search or disease like :search or indigo_id like :search or gender like :search or ethnicity like :search or sample_source_identifier like :search or race like :search or sample_source_study like :search", search:"%#{params[:search][:value]}%")
      end
      samples
    end

    def page
      params[:start].to_i/per_page + 1
    end

    def per_page
      params[:length].to_i > 0 ? params[:length].to_i : 100
    end

    def sort_column
      columns = %w(indigo_id sample_source sample_source_study sample_source_identifier disease gender ethnicity race age_of_onset age_at_sample)
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:order]["0"]["dir"] == "desc" ? "desc" : "asc"
    end
end
