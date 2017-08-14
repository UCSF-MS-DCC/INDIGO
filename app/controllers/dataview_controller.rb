class DataviewController < ApplicationController
  before_action :authenticate_user! #Devise authentication. Resource should only be available to logged in users
  load_and_authorize_resource :class => Sample #Cancancan enforces access on the model level. This hash prevents unauthorized users from accessing this resource by blocking this route.

  def index
    @samples = Sample.where(sample_source: current_user.affiliation).order("indigo_id ASC")
    @indigo_ids = Sample.where(sample_source: current_user.affiliation).distinct.pluck(:indigo_id)
    @hlas = Hla.where(indigo_id:@indigo_ids).order("indigo_id ASC")
    @kirs = Kir.where(indigo_id:@indigo_ids).order("indigo_id ASC")
  end

  def superindex
    if !current_user.has_role? :superuser
      redirect_to '/dataview#index'
    else
      disease = dataview_params[:disease]
      @samples = Sample.where(disease:disease).order("indigo_id ASC")
      ids = @samples.pluck(:id)
      @hlas = Hla.where(sample_id:ids).order("indigo_id ASC")
      @kirs = Kir.where(sample_id:ids).order("indigo_id ASC")
    end
  end

  def stacy
    unless current_user.has_role? :admin
      redirect_to root_path
    end
    respond_to do |format|
      format.html
      format.json { render json: SampleDatatable.new(view_context) }
    end
  end

  def sample_status
    respond_to do |format|
      format.json { render json: SampleDatatable.new(view_context) }
    end
  end

  def modal_content

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

  def download_sample_data
    @samples = Sample.where(sample_source: current_user.affiliation)

    respond_to do |format|
      format.csv { send_data @samples.to_csv }
    end
  end

  def download_hla_data
    @samples = Sample.where(sample_source: current_user.affiliation)
    respond_to do |format|
      format.csv { send_data @samples.to_csv_with_hla }
    end
  end

  def download_kir_data
    @samples = Sample.where(sample_source: current_user.affiliation)
    respond_to do |format|
      format.csv { send_data @samples.to_csv_with_kir }
    end
  end

  def download_hla_data_superuser
    @samples = Sample.all
    respond_to do |format|
      format.csv { send_data @samples.to_csv_with_hla }
    end
  end

  def download_kir_data_superuser
    @samples = Sample.all
    respond_to do |format|
      format.csv { send_data @samples.to_csv_with_kir }
    end
  end

  def download_all_data_superuser
    @samples = Sample.all
    respond_to do |format|
      format.csv { send_data @samples.to_csv_with_hla_and_kir }
    end
  end

  private

    def dataview_params
      params.permit(:disease)
    end


end
