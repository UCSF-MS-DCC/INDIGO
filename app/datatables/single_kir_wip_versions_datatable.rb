class SingleKirWipVersionsDatatable
  delegate :params, :h, to: :@view

  def initialize(view, indigo_id, locus)
    @view = view
    @indigo_id = indigo_id
    @locus = locus
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: KirGenotypeWip.count,
        iTotalDisplayRecords: kir_wip.versions.count - 1,
        aaData:data
    }
  end

  private

  def data
    container = []
    @k = kir_wip
    container.push(
        [
            @indigo_id,
            @locus,
            @k.method,
            @k.batch,
            @k.genotype,
            @k.status,
            @k.updated_at.strftime('%b %d, %Y %H:%M'),
            @k.raw_data_directory,
            @k.kir_extracted_directory,
            @k.output_directory
        ]
    )
    (kir_wip.versions.size - 2).times do
      @k = @k.paper_trail.previous_version
      container.push(
        [
            @indigo_id,
            @locus,
            @k.method,
            @k.batch,
            @k.genotype,
            @k.status,
            @k.updated_at.strftime('%b %d, %Y %H:%M'),
            @k.raw_data_directory,
            @k.kir_extracted_directory,
            @k.output_directory
        ]
      )
    end
    container
  end

  def kir_wip
    @kir_wip ||= fetch_kir_wip
  end

  def fetch_kir_wip
    kir_wips = Sample.find_by(indigo_id:@indigo_id).kir_genotype_wips
    kw = kir_wips.find_by(locus:@locus)
    kw
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