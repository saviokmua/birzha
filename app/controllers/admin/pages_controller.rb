class Admin::PagesController < AdminController
  def index
    per_page = 15
    params[:page]||=1
    @start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
    @pages = Page.paginate(page: params[:page], per_page: per_page).order('title')
  end

  def new
    @page = Page.new()
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:success] = 'Створено новий запис'
      redirect_to admin_pages_path
    else
      flash[:error] = 'Помилка створення нового запису'
      render :new
    end
  end

  def edit
    @page = Page.find_by(id: params[:id])
      if @page.nil?
      flash[:error] = 'Запис не знайдено'
      redirect_to admin_pages_path
     else
    end
  end

  def update
  @page = Page.find_by(id: params[:id])   
  if @page.update(page_params)
      flash[:success] = 'Запис успішно збережений'
      redirect_to admin_pages_path
    else
      flash[:error] = 'Помилка збереження запису'
      render :edit
    end
  end

  def destroy
    @page = Page.find_by(id: params[:id])
    if (@page.nodelete)
      flash[:error] = 'Знищення данного запису заборонено'
    else
      if @page.destroy
        flash[:notice] = 'Знищено запис'
      else
        flash[:error] = 'Помилка знищення запису'
      end
    end
    redirect_to admin_pages_path
  end

private
 def page_params
      params.require(:page).permit(:title, :content, :nodelete)
 end


end
