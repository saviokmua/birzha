class Admin::CategoryController < AdminController
  def index
  	#@articles = Article.all
  	per_page = 15
  	params[:page]||=1
  	@start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
  	@category = Category.paginate(page: params[:page], per_page: per_page).order('name	ASC')
  end

  def new
  	@category = Category.new
  end

  def create
  	@category = Category.new(category_params)
  	if @category.save
  		flash[:success] = 'Створено новий запис'
      redirect_to admin_category_index_path
  	else
  		flash[:error] = 'Помилка створення нового запису'
      render "new"
  	end
  end

  def edit
  	@category = Category.find_by(id: params[:id])
  end

  def update
	@category = Category.find_by(id: params[:id])  	
	if @category.update(category_params)
        redirect_to admin_category_index_path 
        flash[:success] = 'Запис успішно збережений'
  	else
  		flash[:error] = 'Помилка збереження запису'
      render 'edit'
  	end


  end

  def destroy
  	@category = Category.find_by(id: params[:id])
  	if @category.destroy
  		flash[:notice] = 'Знищено запис'
      redirect_to admin_category_index_path
  	else
      flash[:error]=@category.errors.full_messages.join(',')
      #obj=@category
      redirect_to admin_category_index_path 
    end

  end



private
 def category_params
      params.require(:category).permit(:name)
 end


end
