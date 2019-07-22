class WelcomeController < ApplicationController
  def index
  end

  def next
  end

  def progress
    @collabs = Collaborator.where.not(disease:"SCZD")
  end

  def new_progress
  end

  def site_samples_progress
    @collaborator_id = Collaborator.find_by(name:params[:collaborator]).id
    respond_to do |format|
      format.json { render json: SiteProgressDatatable.new(view_context, @collaborator_id) }
    end
  end

  def collaborator_status
    respond_to do |format|
      format.json { render json: CollaboratorStatusDatatable.new(view_context) }
    end
  end

  def immport
  end

  def immport_status_table_data
    respond_to do |format|
      format.json { render json: ImmportStatusDatatable.new(view_context) }
    end
  end

  def samples_table
  end

  def dataset
    @collaborators = Collaborator.all.reject { |c| c.samples.count < 1 }
    @collaborator = Collaborator.find(params[:collaborator_id])
  end

  def samples_processed
    @Samples = Sample.group(:disease).group(:short_date).count
    render json: @Samples
  end

  def dataset_stats
    @id = params[:collaborator_id].to_i
    @Collaborator = Collaborator.find(@id)
    @all_samples = 0
    @samples_to_stanford = 0
    response = {samples_male_cases:0, samples_female_cases: 0, samples_male_controls:0, samples_female_controls:0, hla_available_male_controls:0, hla_available_female_controls:0, hla_available_male_cases:0, hla_available_female_cases:0, samples_total:0, hla_samples_to_stanford:0}
    if @Collaborator.datasets
      @Collaborator.datasets.all.each do |d|
        @all_samples += d.samples_male_controls + d.samples_female_controls + d.samples_male_cases + d.samples_female_cases
        @samples_to_stanford += d.total_samples_sent_to_stanford

        response[:samples_male_cases] += d.samples_male_cases
        response[:samples_female_cases] += d.samples_female_cases
        response[:samples_male_controls] += d.samples_male_controls
        response[:samples_female_controls] += d.samples_female_controls
        response[:hla_available_male_controls] += d.hla_available_male_controls
        response[:hla_available_female_controls] += d.hla_available_female_controls
        response[:hla_available_male_cases] += d.hla_available_male_cases
        response[:hla_available_female_cases] += d.hla_available_female_cases
      end
      response[:samples_total] = @Collaborator.expected_discovery - @all_samples
      response[:hla_samples_to_stanford] = @samples_to_stanford - response[:hla_available_female_cases] - response[:hla_available_male_cases] - response[:hla_available_female_controls] - response[:hla_available_male_controls]
    else
      response = {'message':'no data for this collaborator'}
    end
    render json: response
  end

  def samples_summary_data
    respond_to do |format|
      result = []
      @datasets = Dataset.all.pluck(:disease, :source, :id)
      @datasets.each do |d|
        @batches = Batch.where(Dataset_id:d[2]).pluck(:hlas_available, :kirs_available, :samples_received_at_ucsf, :samples_sent_to_stanford, :id)
        @batches.each do |b|
          sample_count = Sample.where(batch_id:b[4]).count
          b.push(sample_count)
        end
        d.push(@batches)
        result.push(d)
      end
      format.js {render :json => result}
    end
  end

end
