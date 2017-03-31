class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

#  before_filter :authenticate_user!, :set_current_user

  respond_to :html

  def index
    @activities = Activity.all
    respond_with(@activities)
  end

  def show
    respond_with(@activity)
  end

  def new
    @activity = Activity.new
    respond_with(@activity)
  end

  def edit
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.updated_by = current_user.email

    respond_to do |format|
      if @activity.save
        format.html { redirect_to action: "index", notice: 'test was successfully created.' }
      else
        format.html { render action: "new" }
      end

    end

  end

  def update
    @activity.update(activity_params)
    respond_with(@activity)
  end

  def destroy
    @activity.destroy
    respond_with(@activity)
  end

  private
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:activity, :person, :date, :updated_by)
    end

=begin
    def set_current_user
      User.current = current_user
    end
=end

end
