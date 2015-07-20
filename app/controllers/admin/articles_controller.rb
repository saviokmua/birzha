class Admin::ArticlesController < AdminController
  def index
  	#@articles = Article.all
  	per_page = 15
  	params[:page]||=1
  	@start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
  	@articles = Article.paginate(page: params[:page], per_page: per_page).where(news: true).order('title 	ASC')
  end

  def new
  	@article = Article.new({"news" => true})
  end

  def create
  	@article = Article.new(article_params)
  	if @article.save
  		flash[:success] = 'Створено новий запис'
      redirect_to admin_articles_path
  	else
  		flash[:error] = 'Помилка створення нового запису'
      #render new_admin_article_path
      render "new"
  	end
  end

  def edit
  	@article = Article.find_by(id: params[:id])
      if @article.nil?
      @article = Article.new(id: params[:id]).save(validate: false)
     end
    
  end

  def update
	@article = Article.find_by(id: params[:id])  	
	if @article.update(article_params)
  		
      if @article.news
        redirect_to admin_articles_path 
        flash[:success] = 'Запис успішно збережений'
      else
        flash.now[:success] = 'Запис успішно збережений'
        render 'edit' if !@article.news
      end
  	else
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
      params.require(:article).permit(:title, :content, :news)
 end


end
