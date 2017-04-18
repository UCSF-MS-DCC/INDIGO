class DataviewController < ApplicationController
  before_action :authenticate_user! #Devise authentication. Resource should only be available to logged in users
  load_and_authorize_resource :class => Sample #Cancancan enforces access on the model level. This hash prevents unauthorized users from accessing this resource by blocking this route.
  load_and_authorize_resource :class => IDR

  def index
    @samples = Sample.where(sample_source: current_user.affiliation)
    @indigo_ids = Sample.where(sample_source: current_user.affiliation).distinct.pluck(:indigo_id)
    @hlas = Hla.where(indigo_id: @indigo_ids)
    @kirs = Kir.where(indigo_id: @indigo_ids)
    @idrs = IDR.where(sample_source: current_user.affiliation)
  end

  def superindex
    if !current_user.has_role? :superuser
      redirect_to '/dataview#index'
    else
      @samples = Sample.all
      @hlas = Hla.all
      @kirs = Kir.all
    end
  end

  def samples_to_json
    @samples = Sample.where(sample_source: current_user.affiliation)
    render json: @samples
  end

  def superindex_samples_to_json
    @samples = Sample.all
    render json: @samples
  end

  def hlas_to_json
    @indigo_ids = Sample.where(sample_source: current_user.affiliation).distinct.pluck(:indigo_id)
    @hlas = Hla.where(indigo_id: @indigo_ids)
    render json: @hlas
  end

  def superindex_hlas_to_json
    @hlas = Hla.all
    render json: @hlas
  end

  def kirs_to_json
    @indigo_ids = Sample.where(sample_source: current_user.affiliation).distinct.pluck(:indigo_id)
    @kirs = Kir.where(indigo_id: @indigo_ids)
    render json: @kirs
  end

  def superindex_kirs_to_json
    @kirs = Kir.all
    render json: @kirs
  end

  def summary_report_to_json

  end

  def download_idr
    @idrs = IDR.where(sample_source: current_user.affiliation)
    # flash[:notice] = "#{@idrs.count} Indigo Data Records from #{current_user.affiliation}"
    respond_to do |format|
      format.csv { send_data @idrs.to_csv }
    end
  end

  def download_sample_data
    @samples = Sample.where(sample_source: current_user.affiliation)

    respond_to do |format|
      format.csv { send_data @samples.to_csv }
    end
  end

  def download_hla_data
    @samples = Sample.where(sample_source: current_user.affiliation).distinct.pluck(:indigo_id)
    @hlas = Hla.where(indigo_id: @samples)

    respond_to do |format|
      format.csv { send_data @hlas.to_csv }
    end
  end

  def dataview_download_kir_data
    @samples = Sample.where(sample_source: current_user.affiliation).distinct.pluck(:indigo_id)
    @kirs = Kir.where(indigo_id: @samples)

    respond_to do |format|
      format.csv { send_data @kirs.to_csv }
    end
  end

end
