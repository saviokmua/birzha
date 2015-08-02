class Admin::StatusController < AdminController
  before_action :get_status, only: [:edit,:update,:destroy]

  def index
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

  def update
		if @status.update(status_params)
        redirect_to admin_status_index_path 
        flash[:success] = 'Запис успішно збережений'
  	else
  		flash[:error] = 'Помилка збереження запису'
      render 'edit'
  	end
  end

  def destroy
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
    params.require(:status).permit(:name,:documents)
 end

 def get_status
    @status = Status.find(params[:id])    
 end

end