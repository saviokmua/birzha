class Admin::ResultController < AdminController


def index
    per_page = 15
    params[:page]||=1
    @start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
    @results = Result.paginate(page: params[:page], per_page: per_page).order('created_at DESC')
end    

  def new
    @result = Result.new(enable: true,title: "Результати з продажу необробленої деревини")
  end

  def create
    @result = Result.new(result_params)
    if @result.save
      flash[:success] = 'Створено новий запис'
      file_upload @result.id
      redirect_to admin_result_index_path
    else
      flash[:error] = 'Помилка створення нового запису'
      render :new
    end
  end

  def edit
    @result = Result.find_by(id: params[:id])
      if @result.nil?
      flash[:error] = 'Запис не знайдено'
      redirect_to admin_result_index_path
     else

    end
  end

  def update
	result = Result.find_by(id: params[:id])  	
	if result.update(result_params)
      flash[:success] = 'Запис успішно збережений'
      file_upload params[:id]
      redirect_to admin_result_index_path 
   	else
      flash[:error] = 'Помилка збереження запису'
      render result: :edit
  	end
  end

  def destroy
    result = Result.find_by(id: params[:id])
    filename = result.filename
    if result.destroy
      flash[:notice] = 'Знищено запис'
      file_delete filename
    end
    redirect_to admin_result_index_path
  end

private
 def result_params
  params.require(:result).permit(:title, :enable, :date)
 end

def file_upload id
    result = Result.find_by(id: id)   
    uploaded_io = params[:result][:filename]
    if uploaded_io.present? 
      file_delete result.filename
      filename = 'result_'+result.date.to_s+File.extname(uploaded_io.original_filename).to_s
      path = Rails.root.join('public', 'uploads', 'result')
      filename_path = Rails.root.join('public', 'uploads', 'result', filename)
      File.open(filename_path, 'wb') do |file|
       file.write(uploaded_io.read)
      end
      result.update(filename: filename)
      filename_html = convert_to_html filename_path,path
      filename_path_html = Rails.root.join('public', 'uploads', 'result', filename_html)
      if File.file?(filename_path_html)
        result.update(html: filename_html)
      end
    end
end

def file_delete filename
    
    if filename.present?
      file_path = Rails.root.join('public', 'uploads', 'result', filename)
      files=[]
      files << file_path
      files << (File.dirname(file_path).to_s + "/" + File.basename(file_path,'.*').to_s + '.html')

      files.each do |f|
        if File.file?(f.to_s) 
          File.delete(f)
        end
      end
    end
end

def convert_to_html filename_path,path
  cmd="/usr/bin/sudo /usr/bin/libreoffice --headless --convert-to html #{filename_path.to_s} --outdir #{path} "
  `#{cmd}`
  File.basename(filename_path,'.*').to_s+'.html'
end


end