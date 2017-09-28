class SiteProgressDatatable
  delegate :params, :h, to: :@view

  def initialize(view, collaborator_id)
    @view = view
    @collaborator = Collaborator.find(collaborator_id)
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Collaborator.count,
      iTotalDisplayRecords: 1,# collaborators.total_entries,
      aaData:data
    }
  end

  private

    def data
      sample_batches = []
      received_dates = samples.pluck(:received_date).uniq
      to_stanford_dates = samples.pluck(:date_to_stanford).uniq
      studies = samples.pluck(:sample_source_study).uniq
      a = received_dates.size
      b = to_stanford_dates.size
      c = studies.size
      x = 0
      y = 0
      z = 0
      for x in 0...received_dates.size do
        for y in 0...to_stanford_dates.size do
          for z in 0...studies.size do
            unless Sample.where(received_date:"#{received_dates[x]}").where(date_to_stanford:"#{to_stanford_dates[y]}").where(sample_source_study:"#{studies[z]}").size < 1
              sample_batches.push(Sample.where(received_date:"#{received_dates[x]}").where(date_to_stanford:"#{to_stanford_dates[y]}").where(sample_source_study:"#{studies[z]}"))
            end
          end
        end
      end
      puts "sample batches size: #{sample_batches.size}"

      sample_batches.map do |b|

        [
          b.first.sample_source_study,
          b.first.ngs_dataset,
          b.where.not(disease:"HC").count,
          b.where(disease:"HC").count,
          b.first.received_date,
          b.first.date_to_stanford,
          b.first.date_to_stanford == "not sent yet" ? 0 : b.size,
          b.where(kir_raw:true).count,
          b.where(hla_geno:true).count,
          b.where(kir_geno:true).count
        ]
      end
    end

    def samples
      @samples ||= fetch_samples
    end

    def fetch_samples
      samples = Sample.where(collaborator_id:@collaborator.id)
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
