class DataviewController < ApplicationController
  before_action :authenticate_user! #Cancancan authentication. Resource should only be available to logged in users
  load_and_authorize_resource :class => Sample #Cancancan enforces access on the model level. This hash prevents unauthorized users from accessing this resource by blocking this route.

  def index
    @samples = Sample.where(sample_source: current_user.affiliation)
    @indigo_ids = Sample.where(sample_source: current_user.affiliation).distinct.pluck(:indigo_id)
    @hlas = Hla.where(indigo_id: @indigo_ids)
    @kirs = Kir.where(indigo_id: @indigo_ids)
  end

  def download_sample_data
    @samples = Sample.where(site: current_user.affiliation)

    respond_to do |format|
      format.csv { send_data @samples.to_csv }
    end
  end

  def download_hla_data
    @samples = Sample.where(site: current_user.affiliation).distinct.pluck(:indigo_id)
    @hlas = Hla.where(indigo_id: @samples)

    respond_to do |format|
      format.csv { send_data @hlas.to_csv }

    end
  end

  def dataview_download_kir_data
    @samples = Sample.where(site: current_user.affiliation).distinct.pluck(:indigo_id)
    @kirs = Kir.where(indigo_id: @samples)

    respond_to do |format|
      format.csv { send_data @kirs.to_csv }
    end
  end

end
