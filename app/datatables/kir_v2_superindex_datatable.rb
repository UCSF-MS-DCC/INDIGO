class KirV2SuperindexDatatable
  # use this datatable class to format data from Kir2019 table for display in kir superindex views.
  # TODO: make appropriate changes to methods here to work with columns in Kir2019 table.
  delegate :params, :h, to: :@view

  def initialize(view, disease)
    @view = view
    @disease = disease
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Kir2019.count,
        iTotalDisplayRecords: kirs.total_entries,
        aaData:data
    }
  end

  private

  def data
    kirs.map do |kir|
      sample = kir.sample ? kir.sample : nil
      source = sample.collaborator ? sample.collaborator.name : "-"
      [
          kir.indigo_id,
          source,
          kir.kir2dl4_1,
          kir.kir2dl4_2,
          kir.kir2dl4_status,
          kir.v_ping_kir2dl4,
          kir.kir2dl23_1,
          kir.kir2dl23_2,
          kir.kir2dl23_status,
          kir.v_ping_kir2dl23,
          kir.kir3dl1s1_1,
          kir.kir3dl1s1_2,
          kir.kir3dl1s1_status,
          kir.v_ping_kir3dl1s1,
          kir.kir3dl2_1,
          kir.kir3dl2_2,
          kir.kir3dl2_status,
          kir.kir3dl3_1,
          kir.kir3dl3_2,
          kir.kir3dl3_status,
          kir.v_ping_kir3dl3
      ]
    end
  end

  def kirs
    @kirs ||= fetch_kirs
  end

  def fetch_kirs
    if /,/.match(@disease)
      @disease = @disease.split(",")
    end
    samples = Sample.where(disease:@disease).pluck(:id)
    kirs = Kir2019.where(sample_id:samples).order("#{sort_column} #{sort_direction}")
    kirs = kirs.paginate(:page => page, :per_page => per_page) #per_page == limit(value) page == offset
    term = params[:search][:value]
    term = term.to_s
    if params[:search][:value].present?
      kirs = kirs.where('indigo_id like :search or "kir2dl4_1" like :search or "kir2dl4_2" like :search or "kir2dl4_status" like :search or "kir2dl23_1" like :search or "kir2dl23_2" like :search or "kir2dl23_status" like :search or "kir3dl1s1_1" like :search or "kir3dl1s1_2" like :search or "kir3dl1s1_status" like :search
         or "kir3dl2_1" like :search or "kir3dl2_2" like :search or "kir3dl2_status" like :search or "kir3dl3_1" like :search or "kir3dl3_2" like :search or "kir3dl3_status" like :search or "v_ping_kir2dl4" like :search or "v_ping_kir2dl23" like :search or "v_ping_kir3dl1s1"
         like :search or "v_ping_kir3dl3" like :search' , search:"%#{term}%")
    end
    kirs
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
