class Admin::CategoryController < AdminController
before_action :get_category, only: [:edit,:update,:destroy]

  def index
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

  def update
	if @category.update(category_params)
        redirect_to admin_category_index_path 
        flash[:success] = 'Запис успішно збережений'
  	else
  		flash[:error] = 'Помилка збереження запису'
      render 'edit'
  	end
  end

  def destroy
  	if @category.destroy
  		flash[:notice] = 'Знищено запис'
      redirect_to admin_category_index_path
  	else
      flash[:error]=@category.errors.full_messages.join(',')
      redirect_to admin_category_index_path 
    end
  end

private
  def category_params
    params.require(:category).permit(:name)
  end

  def get_category
    @category = Category.find(params[:id])   
  end

end
