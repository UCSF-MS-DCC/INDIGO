class Api::V2Controller < ApplicationController
  acts_as_token_authentication_handler_for User
 # before_action :authenticate_user!
  before_action :set_page, except: [:kir_work_in_progress]
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
  #load_and_authorize_resource :sample, :parent => false
  include Api::V2Helper
  before_action only:[:sample, :hla, :kir] do
    @samples = apply_query_filters(@samples, query_string_params)
  end

  def sample

    if @samples && @samples.count > 0
      @samples = @samples.paginate(page:@current_page, per_page:500)
      render json: @samples, each_serializer:SampleSerializer, status: :ok
    else
      render json: ["No Samples: Your request returned no samples."], status: :no_content
    end

  end

  def hla

    genes = %w(a b c drb1 dqb1 dpb1 dpa1 dqa1 drbo)
    genes_to_serialize = {"a":false, "b":false, "c":false, "dpa1":false, "dqa1":false, "drb1":false, "dqb1":false, "dpb1":false, "drbo":false}
    serialize_all = true

    if (query_string_params[:gene])
      query_string_params[:gene].each do |gene|
        if genes.include? gene.downcase
          genes_to_serialize[gene.downcase] = true
          serialize_all = false
        end
      end
    end

    if @samples && @samples.count > 0
      @samples = @samples.where(hla_geno:true).paginate(page:@current_page, per_page:500)

      if serialize_all
        render json: @samples, each_serializer: HlaSerializer, genelist:"all", status: :ok
      else
        render json: @samples, each_serializer: HlaSerializer, genelist:genes_to_serialize, status: :ok
      end
    else
      render json: ["Your request returned no matching HLA."], status: :no_content
    end

  end

  def kir

    genes = %w(2dl1 2dl2 2dl3 2dl4 2dl5a 2dl5b 2dp1 2ds1 2ds2 2ds3 2ds4 2ds5 3dl1 3dl2 3dl3 3ds1)
    genes_to_serialize = {"kir_2DL1":false, "kir_2DL2":false, "kir_2DL3":false, "kir_2DL4":false, "kir_2DL5A":false, "kir_2DL5B":false, "kir_2DP1":false, "kir_2DS1":false, "kir_2DS2":false, "kir_2DS3":false, "kir_2DS4":false, "kir_2DS5":false, "kir_3DL1":false, "kir_3DL2":false, "kir_3DL3":false, "kir_3DS1":false}
    serialize_all = true

    if (query_string_params[:gene])
      query_string_params[:gene].each do |gene|
        if genes.include? gene.downcase
          genes_to_serialize["kir_#{gene.upcase}"] = true
          serialize_all = false
        end
      end
    end

    if @samples && @samples.count > 0
      @samples = @samples.where(kir_geno:true).paginate(page:@current_page, per_page:500)

      if serialize_all
        render json: @samples, each_serializer: KirSerializer, genelist:"all", status: :ok
      else
        render json: @samples, each_serializer: KirSerializer, genelist:genes_to_serialize, status: :ok
      end
    else
      render json: ["Your request returned no matching KIR."], status: :no_content
    end

  end # closes kir action definition

  def kir_pipeline
    @user = User.find_by(email:params[:user_email])
    if !@user.is_kir_bioinformatician?
      render json: ["You are not authorized to use this endpoint"], status: :unauthorized
      return
    end
    @sample = Sample.find_by(indigo_id:kir_pipeline_params[:indigo_id])
    @kir_wip = @sample.kir_genotype_wips.find_by(locus:kir_pipeline_params[:locus])

    create_params =  kir_pipeline_params.permit(params.keys).to_h
    create_params.delete(:indigo_id)

    if @sample && @kir_wip
      if @kir_wip.update_attributes(create_params)
        render json: [@kir_wip], each_serializer: KirWipSerializer, status: :ok
      else
        render json: [@kir_wip.errors], status: :unprocessable_entity
      end
    elsif @sample && !@kir_wip
      create_params['sample_id'] = @sample.id
      @kw = KirGenotypeWip.new(create_params)
      if @kw.save
        render json: [@kw], each_serializer: KirWipSerializer, status: :ok
      else
        render json: [@kw_errors], status: :unprocessable_entity
      end
    else
      render json: ["No Sample with this Indigo ID"], status: :unprocessable_entity
    end

  end #close def kir_pipeline
  private

    def query_string_params
      params.permit(:page, :diagnosis, :sex, :controls, :source, :gene => [])
    end

    def kir_pipeline_params
      params.permit("locus", "status", "output_directory", "kir_extracted_directory", "raw_data_directory", "batch", "method", "method_version", "genotype", "indigo_id")
    end

end