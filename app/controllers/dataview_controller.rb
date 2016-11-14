class DataviewController < ApplicationController
  before_action :authenticate_user! #Cancancan authentication. Resource should only be available to logged in users
  load_and_authorize_resource :class => Sample #Cancancan enforces access on the model level. This hash prevents unauthorized users from accessing this resource by blocking this route.

  def index
    @samples = Sample.where(site: current_user.affiliation)
  end

  def download_sample_data
    @samples = Sample.where(site: current_user.affiliation)

    respond_to do |format|
      format.csv { send_data @samples.to_csv }
    end
  end



end
