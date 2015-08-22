class ArticlesController < ApplicationController

  def index
   	per_page = 15
  	params[:page]||=1
  	@start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
  	@articles = Article.paginate(page: params[:page], per_page: per_page).where(news: true).order('created_at DESC')
  end

  def show
  	@article = Article.find_by(id: params[:id])
  end

end
