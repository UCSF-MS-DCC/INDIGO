class DataviewController < ApplicationController
  before_action :authenticate_user! #Devise authentication. Resource should only be available to logged in users
   #Cancancan enforces access on the model level. This hash prevents unauthorized users from accessing this resource by blocking this route.

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
      @disease = dataview_params[:disease]
      @samples = Sample.where(disease:@disease).order("indigo_id ASC")
      ids = @samples.pluck(:id)
      @hlas = Hla.where(sample_id:ids).order("indigo_id ASC")
      @kirs = Kir.where(sample_id:ids).order("indigo_id ASC")
    end
  end

  def kir_genotyping_work_in_progress
    unless current_user.is_kir_bioinformatician?
      redirect_to root_path
    end
  end

  def single_kir_genotype
    indigo_id = params[:id].split("_")[0]
    locus = params[:id].split("_")[1]
    # these @ variables are to set values in the DOM, to be read by the datatable initializer in dataview.js.erb
    @indigo_id = indigo_id
    @gene = locus
    @kir_wips = KirGenotypeWip.where(indigo_id:indigo_id, locus:locus).order("locus ASC").order("method ASC")
  end

  def kir_wip_data
    respond_to do |format|
      format.html
      format.json { render json: KirWipDatatable.new(view_context)}
    end
  end

  def kw_sg_am_data
    puts params[:indigo_id]
    puts params[:gene]
    respond_to do |format|
      format.html
      format.json { render json: KwSgAmDatatable.new(view_context, params[:indigo_id], params[:gene]) }
    end
  end

  def stacy
    unless current_user.has_role? :superuser
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

  def samples_index
    respond_to do |format|
      format.json { render json: SampleIndexDatatable.new(view_context, current_user.affiliation) }
    end
  end

  def hla_index
    respond_to do |format|
      format.json { render json: HlaIndexDatatable.new(view_context, current_user.affiliation) }
    end
  end

  def kir_index
    respond_to do |format|
      format.json { render json: KirIndexDatatable.new(view_context, current_user.affiliation) }
    end
  end

  def samples_superindex
    disease = params[:disease]
    respond_to do |format|
      format.json { render json: SampleSuperindexDatatable.new(view_context, disease) }
    end
  end

  def hla_superindex
    disease = params[:disease]
    respond_to do |format|
      format.json { render json: HlaSuperindexDatatable.new(view_context, disease) }
    end
  end

  def kir_superindex
    disease = params[:disease]
    respond_to do |format|
      format.json { render json: KirSuperindexDatatable.new(view_context, disease) }
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
    @samples = Sample.all

    respond_to do |format|
      format.csv { send_data @samples.master_samples_table_to_csv }
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
