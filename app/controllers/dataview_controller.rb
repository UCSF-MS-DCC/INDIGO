class DataviewController < ApplicationController
  before_action :authenticate_user! #Devise authentication. Resource should only be available to logged in users
   #Cancancan enforces access on the model level. This hash prevents unauthorized users from accessing this resource by blocking this route.
  @sv = "DEFAULT"
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
      longform_names = { :PD => "Parkinson's Disease", :MS => "Multiple Sclerosis", :MG => "Myasthenia Gravis", :NMO => "Neuromyelitis Optica", :ALS => "Amyotrophic Lateral Sclerosis", :HC => "Unaffected Controls", :SCZD => "Schizophrenia", :'Not MS - Unaffected - Related' => "Unaffected MS-related", :PANS => "Pediatric Acute-onset Neuropsychiatric Syndrome" }
      if dataview_params[:disease].size == 1
        @disease = dataview_params[:disease][0]
        @header_content = longform_names[@disease.to_sym]
      else
        @disease = dataview_params[:disease].join(",")
        @disease_sym = dataview_params[:disease][0]
        @header_content = longform_names[@disease_sym.to_sym]
      end
      @samples = Sample.where(disease:@disease).order("indigo_id ASC")
      ids = @samples.pluck(:id)
      @hlas = Hla.where(sample_id:ids).order("indigo_id ASC")
      @kirs = Kir.where(sample_id:ids).order("indigo_id ASC")
    end
  end

  def superindex_race_graph
    @dis = /,/.match(dataview_params[:disease][0]) ? dataview_params[:disease][0].split(",") : dataview_params[:disease]
    races = Sample.where(disease:@dis).where.not(race:nil).pluck(:race).uniq
    output = races.map { |r|
      {:race => r, :samples => Sample.where(disease:@dis).where(race:r).count}
    }
    output.sort_by { |hsh| hsh[:race] }
    if Sample.where(disease:@dis).where(race:nil).count > 0
      output.push({:race => 'NA', :samples => Sample.where(disease:@dis).where(race:nil).count})
    end
    puts output
    render json: output, status: :ok
  end

  def superindex_sex_graph
    @dis = /,/.match(dataview_params[:disease][0]) ? dataview_params[:disease][0].split(",") : dataview_params[:disease]
    longform_names = {:F => "Female", :M => "Male"}
    sexes = Sample.where(disease:@dis).where.not(gender:nil).pluck(:gender).uniq
    sexes = sexes.map(&:downcase)
    sexes.uniq!
    output = sexes.map { |s|
        {:sex => longform_names[s.to_sym], :samples => Sample.where(disease:@dis).where(gender:s).count}
    }
    if Sample.where(disease:@dis).where(gender:nil).count > 0
      output.push({:sex => 'NA', :samples => Sample.where(disease:@dis).where(gender:nil).count})
    end
    render json: output, status: :ok
  end

  def superindex_age_graph
    @dis = /,/.match(dataview_params[:disease][0]) ? dataview_params[:disease][0].split(",") : dataview_params[:disease]
    set_min = Sample.where(disease:@dis).where.not(age_of_onset:nil).pluck(:age_of_onset).uniq.min
    set_max = Sample.where(disease:@dis).where.not(age_of_onset:nil).pluck(:age_of_onset).uniq.max
    min_age = set_min
    max_age = min_age % 10 == 0 ? min_age + 10 : min_age + (10 - (min_age % 10))

    output = []
    while min_age < set_max
      output.push({:range => "#{min_age} - #{max_age}", :samples => Sample.where(disease:@dis).where("age_of_onset >= ?", min_age).where("age_of_onset <= ?", max_age).count })
      min_age = max_age + 1
      max_age = max_age + 10
    end
    if Sample.where(disease:@dis).where(age_of_onset:nil).count > 0
      output.push({:range => "NA", :samples => Sample.where(disease:@dis).where(age_of_onset:nil).count})
    end
    render json: output, status: :ok
  end

  def kir_genotyping_work_in_progress
    unless current_user.is_kir_bioinformatician?
      redirect_to root_path
    end
    @versions = KirGenotypeWip.pluck(:method_version).uniq
  end

  def single_kir_genotype
    indigo_id = params[:id].split("_")[0]
    locus = params[:id].split("_")[1]
    # these @ variables are to set values in the DOM, to be read by the datatable initializer in dataview.js.erb
    @indigo_id = indigo_id
    @gene = locus
    @kir_wips = KirGenotypeWip.where(indigo_id:indigo_id, locus:locus).order("locus ASC").order("method ASC")
  end

  def single_kir_genotype_version_table
    @sample_indigo_id = params[:indigo_id]
    @sample_locus = params[:locus]
  end

  def single_kir_wip_versions_data
    respond_to do |format|
      format.html
      format.json { render json: SingleKirWipVersionsDatatable.new(view_context, params[:indigo_id], params[:locus]) }
    end
  end

  def kir_wip_data
    respond_to do |format|
      format.html
      format.json { render json: KirWipDatatable.new(view_context)}
    end
  end

  def method_version
    unless current_user.is_kir_bioinformatician?
      redirect_to root_path
    end
    @current_version = params[:method_version]
    @versions = KirGenotypeWip.pluck(:method_version).uniq
  end

  def method_version_data
    respond_to do |format|
      format.html
      format.json { render json: MethodVersionDatatable.new(view_context, params[:method_version])}
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
    # respond_to do |format|
    #   format.html
    #   format.json { render json: SampleDatatable.new(view_context) }
    # end
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
      format.json { render json: KirV2SuperindexDatatable.new(view_context, disease) }
    end
  end

  def modal_content
    puts params[:indigo_id]
    @sample_id = Sample.find_by(indigo_id:params[:indigo_id]).sample_source_identifier
    respond_to do |format|
      format.json { render json: {"study_id": @sample_id} }
    end
  end

  def allele_frequencies
    unless current_user.has_role? :superuser
      redirect_to root_path
    end
  end

  def allele_frequencies_data
    respond_to do |format|
      format.json { render json: AlleleFrequenciesDatatable.new(view_context) }
    end
  end

  def haplotype_frequencies

  end

  def haplotype_frequencies_data
# pass the haplotype scope as a second parameter to the Datatable instantiation
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
    puts @sv
    @samples = Sample.all
    # respond_to do |format|
    #   format.csv { send_data @samples.master_samples_table_to_csv }
    # end
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
      params.permit(:disease => [])
    end


end
