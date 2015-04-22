class ApisController < ApplicationController
  def index
    if !params[:api_key]
      redirect_to new_api_path
    end
  end

  def new
    @api = Api.new
  end

  def create
    @api = Api.new(api_params)
    api_key = SecureRandom.hex
    @api.id = api_key
    if @api.save
      redirect_to :controller => :apis, :action => 'index', :api_key => api_key
    else
      redirect_to new_api_path
    end
  end

  private
  def api_params
    params.require(:api).permit(:id)
  end
end
