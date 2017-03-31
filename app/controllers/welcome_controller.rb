class WelcomeController < ApplicationController
  def index
  end

  def next
  end

  def progress
    @datasets = Dataset.all
    @collaborators = Collaborator.all.order('disease ASC')
    @total_proposed = 0
    @total_received = 0
    @total_to_stanford = 0
    @total_hla_controls = 0
    @total_hla_cases = 0
    @total_kir_controls = 0
    @total_kir_cases = 0
    Collaborator.all.each do |c|
      if c.expected_discovery != nil
        @total_proposed += c.expected_discovery
      end
      c.datasets.each do |d|
        d.batches.each do |b|
          @total_received += b.samples.count
          if b.to_stanford
            @total_to_stanford += b.samples.count
          end
          @total_hla_controls += b.hlas_control_male + b.hlas_control_female + b.hlas_control_gender_unknown
          @total_hla_cases += b.hlas_case_male + b.hlas_case_female + b.hlas_case_gender_unknown
          @total_kir_controls += b.kirs_control_male + b.kirs_control_female + b.kirs_control_gender_unknown
          @total_kir_cases += b.kirs_case_male + b.kirs_case_female + b.kirs_case_gender_unknown
        end
      end
    end
  end

  def samples_table
  end

  def dataset
    @collaborators = Collaborator.all
    @collaborator = Collaborator.find(params[:collaborator_id])
    @datasets = @collaborator.datasets
  end

  def samples_processed
    # @idrs = IDR.where(sample_source: current_user.affiliation).sort_by{ |i| [i.disease, i.created_at] }
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
