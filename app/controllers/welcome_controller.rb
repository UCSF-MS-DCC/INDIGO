class WelcomeController < ApplicationController
  def index
  end

  def next
  end

  def progress
    @datasets = Dataset.all
  end

  def samples_table
  end

  def dataset
    @dataset = Dataset.find(params[:dataset_id])
  end

  def samples_processed
    # @idrs = IDR.where(sample_source: current_user.affiliation).sort_by{ |i| [i.disease, i.created_at] }
    @Samples = Sample.group(:disease).group(:short_date).count
    render json: @Samples
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
