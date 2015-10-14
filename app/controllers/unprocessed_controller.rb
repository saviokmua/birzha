class UnprocessedController < ApplicationController

  before_action :get_unprocessed, only: [:show,:download]

  def index
    per_page = 25
    params[:page]||=1
    @start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
    @unprocesseds = unprocessed.paginate(page: params[:page], per_page: per_page).includes(:status).includes(:category).order("started_at DESC")
  end
  
  def download
    send_file(Rails.root.join('public', 'uploads','unprocessed', @unprocessed.filename),filename: @unprocessed.filename_origin)
  end

  def show
    @unprocessed = Unprocessed.find_by(id: params[:id])
  end
  

  private

  def unprocessed_params
    params.require(:unprocessed).permit(:id)
  end

  

  def get_unprocessed
    @unprocessed = Unprocessed.find(params[:id])
  end

  

end