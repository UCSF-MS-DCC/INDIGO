class SampleDatatable
  delegate :params, :h, to: :@view

  def initialize(view)
    @view = view
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
          sample.sample_source,
          sample.sample_source_study,
          sample.sample_source_identifier,
          sample.disease,
          sample.received_date,
          sample.date_to_stanford,
          sample.ngs_dataset,
          sample.hla_geno,
          sample.kir_geno,
          sample.kir_raw
        ]
      end
    end

    def samples
      @samples ||= fetch_samples
    end

    def fetch_samples
      samples = Sample.order("#{sort_column} #{sort_direction}")
      samples = samples.paginate(:page => page, :per_page => per_page) #per_page == limit(value) page == offset
      if params[:search][:value].present?
        samples = samples.where("sample_source like :search or disease like :search", search:"%#{params[:search][:value]}%")
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
      columns = %w(indigo_id sample_source sample_source_study sample_source_identifier disease received_date date_to_stanford ngs_dataset hla_geno kir_geno kir_raw)
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:order]["0"]["dir"] == "desc" ? "desc" : "asc"
    end
end
