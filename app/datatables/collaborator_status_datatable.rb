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
      collection = []
      collaborators.each do |c|
      diags = c.samples.pluck(:disease).uniq 
      sample_ids = c.samples.pluck(:id).uniq
      diags.each do |d|
        row = [
            c.name,
            d,
            c.sequence_type,
            c.samples.where(disease:d).count,
            c.samples.where(disease:d).where.not(date_to_stanford:nil).where.not(date_to_stanford:"not sent yet").count,
            c.samples.where(uploaded_to_immport:true).count,
            c.samples.where(disease:d).where(hla_geno:true).count,
            Hla.where(sample_id:sample_ids).where(uploaded_to_immport:true).count,
            c.sequence_type == 'KIR only' ? 0 : c.samples.where(disease:d).where(hla_geno:false).count,
            c.sequence_type == 'HLA only' ? 0 : c.samples.where(disease:d).where(kir_raw:true).count,
            c.samples.where(disease:d).where(kir_geno:true).count,
            Kir2019.where(sample_id:sample_ids).where(uploaded_to_immport:true).count,
            c.samples.where(disease:d).where(kir_geno:false).where(kir_raw:true).count
          ]
          collection.push(row)
        end
      end
      collection
    end

    def collaborators
      collaborators ||= fetch_collaborators
    end

    def fetch_collaborators
      collabs = Collaborator.where.not(disease:"SCZD").order("#{sort_column} #{sort_direction}")
      collabs = collabs.paginate(:page => page, :per_page => per_page)
      collabs
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
