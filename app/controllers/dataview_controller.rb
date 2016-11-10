class DataviewController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  def index
    @samples = Sample.where(site: current_user.affiliation)
  end


end
