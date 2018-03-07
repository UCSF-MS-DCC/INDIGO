class AlleleFrequenciesDatatable
  delegate :params, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Collaborator.count,
        iTotalDisplayRecords: allele_frequencies.total_entries,
        aaData:data
    }
  end

  private

  def data
    allele_frequencies.map do |f|

      [
          f.locus,
          f.genotype,
          f.frequency,
          f.disease,
          f.collaborator.name

      ]
    end
  end

  def allele_frequencies
    @allele_frequencies ||= fetch_allele_frequencies
  end

  def fetch_allele_frequencies
    frequencies = AlleleFrequency.order("locus asc").order("genotype asc").order("disease asc").order("frequency asc")
    frequencies = frequencies.paginate(:page => page, :per_page => per_page)
    frequencies
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
