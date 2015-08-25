class Admin::ArticlesController < AdminController
  def index
  	per_page = 15
  	params[:page]||=1
  	@start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
  	@articles = Article.paginate(page: params[:page], per_page: per_page).order('created_at DESC')
  end

  def new
    @auctions= Auction.all
    @article = Article.new()
  end

  def create
  	@article = Article.new(article_params)
  	if @article.save
  		flash[:success] = 'Створено новий запис'
      redirect_to admin_articles_path
  	else
  		flash[:error] = 'Помилка створення нового запису'
      #render new_admin_article_path
      @auctions= Auction.all
      render action: :new
  	end
  end

  def edit
  	@auctions= Auction.all
    @article = Article.find_by(id: params[:id])
      if @article.nil?
      #@article = Article.new(id: params[:id]).save(validate: false)
      flash[:error] = 'Запис не знайдено'
      redirect_to admin_articles_path
     else
    end
  end

  def update
	@article = Article.find_by(id: params[:id])  	
	if @article.update(article_params)
      flash[:success] = 'Запис успішно збережений'
      redirect_to admin_articles_path 
   	else
      @auctions= Auction.all
      flash[:error] = 'Помилка збереження запису'
      render 'edit'
  	end
  end

  def destroy
  	@article = Article.find_by(id: params[:id])
  	if @article.destroy
  		flash[:notice] = 'Знищено запис'
      redirect_to admin_articles_path
  	end
  end



private
 def article_params
      params.require(:article).permit(:title, :content, :auction_id, :auction_enable)
 end


end
