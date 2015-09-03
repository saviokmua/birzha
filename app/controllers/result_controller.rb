class ResultController < ApplicationController

  def index
   	
    per_page = 15
  	params[:page]||=1
  	@start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
  	@results = Result.paginate(page: params[:page], per_page: per_page).where(enable: true).order('date DESC')
  end



end
