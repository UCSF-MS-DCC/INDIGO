class DataviewController < ApplicationController
  before_action :authenticate_user! #Cancancan authentication. Resource should only be available to logged in users
  load_and_authorize_resource :class => Sample #Cancancan enforces access on the model level. This hash prevents unauthorized users from accessing this resource by blocking this route.

  def index
    @samples = Sample.where(site: current_user.affiliation)
    @ids = @samples.collect { |s| s.indigo_id }
    @hlas = []
    @kirs = []
    @ids.each do |id|
      if Hla.where(indigo_id: id)
        hla = Hla.where(indigo_id: id)
        @hlas.push(hla[0])
      end
        if Kir.where(indigo_id: id)
        kir = Kir.where(indigo_id: id)
        @kirs.push(kir)
      end
    end
  end

  def download_sample_data
    @samples = Sample.where(site: current_user.affiliation)

    respond_to do |format|
      format.csv { send_data @samples.to_csv }
    end
  end

  def download_hla_data
    @samples = Sample.where(site: current_user.affiliation)
    @indigo_ids = @samples.collect { |s| s.indigo_id }
    @hlas = []
    @hla_ids = []
    @indigo_ids.each do |id|
      if Hla.where(indigo_id: id)
        hla = Hla.where(indigo_id: id)
        @hla_ids.push(hla[0].id)
      end
    end
    @hla_ids.each do |hid|
      @hla = Hla.find(hid)
      @hlas.push(@hla)
    end

    respond_to do |format|
      format.csv { send_data @hlas.to_csv }

    end
  end

end
