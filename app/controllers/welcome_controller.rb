class WelcomeController < ApplicationController
  def index
  end

  def next
  end

  def progress_chart
  end

  def samples_processed
    # @idrs = IDR.where(sample_source: current_user.affiliation).sort_by{ |i| [i.disease, i.created_at] }
    @Samples = Sample.group(:disease).group(:short_date).count
    render json: @Samples

  end

end
