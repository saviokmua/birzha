class Admin::StatusController < AdminController
  def index
  	#@articles = Article.all
  	per_page = 15
  	params[:page]||=1
  	@start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
  	@status = Status.paginate(page: params[:page], per_page: per_page).order('name	ASC')
  end

  def new
  	@status = Status.new
  end

  def create
  	@status = Status.new(status_params)
  	if @status.save
  		flash[:success] = 'Створено новий запис'
      redirect_to admin_status_index_path
  	else
  		flash[:error] = 'Помилка створення нового запису'
      render "new"
  	end
  end

  def edit
  	@status = Status.find_by(id: params[:id])
  end

  def update
	@status = Status.find_by(id: params[:id])  	
	if @status.update(status_params)
        redirect_to admin_status_index_path 
        flash[:success] = 'Запис успішно збережений'
  	else
  		flash[:error] = 'Помилка збереження запису'
      render 'edit'
  	end


  end

  def destroy
  	@status = Status.find_by(id: params[:id])
  	if @status.destroy
  		flash[:notice] = 'Знищено запис'
      redirect_to admin_status_index_path
  	else
      flash[:error]=@status.errors.full_messages.join(',')
      redirect_to admin_status_index_path
    end 
  end



private
 def status_params
      params.require(:status).permit(:name)
 end


end
