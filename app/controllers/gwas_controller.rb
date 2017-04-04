class GwasController < ApplicationController
  before_action :set_gwa, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @gwas = Gwas.all
    respond_with(@gwas)
  end

  def show
    respond_with(@gwa)
  end

  def new
    @gwa = Gwas.new
    respond_with(@gwa)
  end

  def edit
  end

  def create
    @gwa = Gwas.new(gwa_params)
    @gwa.save
    respond_with(@gwa)
  end

  def update
    @gwa.update(gwa_params)
    respond_with(@gwa)
  end

  def destroy
    @gwa.destroy
    respond_with(@gwa)
  end

  private
    def set_gwa
      @gwa = Gwas.find(params[:id])
    end

    def gwa_params
      params[:gwa]
    end
end
