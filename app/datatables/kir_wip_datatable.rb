class KirWipDatatable
  delegate :params, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: KirGenotypeWip.count,
        iTotalDisplayRecords: kir_wips.total_entries,
        aaData:data
    }
  end

  private

  def data
    kir_wips.map do |k|

      [
          k.sample ? k.sample.indigo_id : "placeholder",
          k.locus,
          k.method,
          k.batch,
          k.genotype,
          k.status,
          k.versions.count > 1 ? k.versions.count - 1 : k.versions.count,
          k.method_version,
          k.raw_data_directory,
          k.kir_extracted_directory,
          k.output_directory

      ]
    end
  end

  def kir_wips
    @kir_wips ||= fetch_kir_wips
  end

  def fetch_kir_wips
    kir_wips = KirGenotypeWip.order("#{sort_column} #{sort_direction}")
    kir_wips = kir_wips.paginate(:page => page, :per_page => per_page) #per_page == limit(value) page == offset

    kir_wips
  end

  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 100
  end

  def sort_column
    columns = %w(id)
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:order]["0"]["dir"] == "desc" ? "desc" : "asc"
  end
end
