class Admin::UnprocessedController < AdminController
  before_action :get_unprocessed, only: [:edit,:update,:get_filename_origin]

  def index
    per_page = 25
    params[:page]||=1
    @start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
    @unprocesseds = Unprocessed.paginate(page: params[:page], per_page: per_page).order('title')
  end

  def new
    @unprocessed = Unprocessed.new(visible: 1)
  end

  def edit
    @unprocessed = Unprocessed.find_by(id: params[:id])
    if @unprocessed.nil?
      flash[:error] = 'Запис не знайдено'
      redirect_to admin_unprocessed_path
    end
  end
  
  def create
    @unprocessed = Unprocessed.new(unprocessed_params)
    if @unprocessed.save
      flash[:success] = 'Створено новий запис'
      file_upload @unprocessed.id
      redirect_to admin_unprocessed_index_path
    else
      flash[:error] = 'Помилка створення нового запису'
      render "new"
    end
  end

  
  def update
    if @unprocessed.update(unprocessed_params)
      flash[:success] = 'Запис успішно збережений'
      file_upload params[:id]
      redirect_to admin_unprocessed_index_path 
    else
      flash[:error] = 'Помилка збереження запису'
      render 'edit'
    end
  end

  def destroy
    @unprocessed = Unprocessed.find_by(id: params[:id])
    if @unprocessed.destroy
      flash[:notice] = 'Знищено запис'
    end
    redirect_to admin_unprocessed_index_path
  end

  def file_destroy
    file_delete params[:unprocessed_id]
    @unprocessed=Unprocessed.find(params[:unprocessed_id])
    respond_to do |format|
      format.html { redirect_to admin_unprocessed_path(params[:unprocessed_id]) }
      format.js
      format.json 
    end    
  end

  private

  def unprocessed_params
    params.require(:unprocessed).permit(:title,:content,:visible)
  end

  def file_upload id
    uploaded_io = params[:unprocessed][:file]
    if uploaded_io.present? 
      file_delete id
      filename=id.to_s+'_'+uploaded_io.original_filename
      File.open(Rails.root.join('public', 'uploads','unprocessed', filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      Unprocessed.update(id,filename: filename)
    end
  end

  def file_delete id
    @unprocessed=Unprocessed.find_by(id: id)
    if @unprocessed.filename.present? 
      file_path = Rails.root.join('public', 'uploads','unprocessed', @unprocessed.filename)
      if File.file?(file_path) 
        File.delete(file_path)
        Unprocessed.update(id,filename: nil) 
      end
    end
  end

  def get_unprocessed
    @unprocessed = Unprocessed.find(params[:id])
  end
end