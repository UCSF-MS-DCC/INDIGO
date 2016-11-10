class KeysController < ApplicationController
  before_action :set_key, only: [:destroy]

  def index
    @keys = Key.all
  end

  def new
    @key = Key.new
  end

  def create
    @key = Key.new(key_params)

    if @resume.save
      redirect_to keys_path, notice: "Key file successfully uploaded"
    else
      render "new"
    end
  end

  def destroy
  end

  private

    def key_params
      params.require(:key).permit(:keyfile)
    end

    def set_key
      @key = Key.find(params[:id])
    end
end
