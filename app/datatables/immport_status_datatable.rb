class ImmportStatusDatatable
    delegate :params, :h, to: :@view
  
    def initialize(view)
      @view = view
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
        output = []
        dates = Set.new(Sample.where(uploaded_to_immport:true).pluck(:immport_upload_date).uniq + Hla.where(uploaded_to_immport:true).pluck(:immport_upload_date).uniq + Kir2019.where(uploaded_to_immport:true).pluck(:immport_upload_date).uniq).sort 
        dates.each do |d|
            sams = Sample.where(uploaded_to_immport:true).where(immport_upload_date:d)
            hlas = Hla.where(uploaded_to_immport:true).where(immport_upload_date:d)
            kirs = Kir2019.where(uploaded_to_immport:true).where(immport_upload_date:d)
            output.push([
                d,
                "-",
                "-",
                sams.count,
                hlas.count,
                kirs.count
            ])
        end
        output
      end
  
      def samples
        @samples ||= fetch_samples
      end
  
      def fetch_samples
        samples = Sample.all
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