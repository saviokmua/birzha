class Admin::ResultController < AdminController


def index
    per_page = 15
    params[:page]||=1
    @start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
    @results = Result.paginate(page: params[:page], per_page: per_page).order('created_at DESC')
end    

  def new
    @result = Result.new(enable: true)
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
	if propoz.update(propoz_params)
      flash[:success] = 'Запис успішно збережений'
      file_upload params[:id]
      redirect_to admin_propoz_index_path 
   	else
      flash[:error] = 'Помилка збереження запису'
      render propoz: :edit
  	end
  end

  def destroy
    propoz = Propoz.find_by(id: params[:id])
    filename = propoz.filename
    if propoz.destroy
      flash[:notice] = 'Знищено запис'
      file_delete filename
    end
    redirect_to admin_propoz_index_path
  end

private
 def propoz_params
  params.require(:propoz).permit(:title, :enable)
 end

def file_upload id
    propoz = Propoz.find_by(id: id)   
    uploaded_io = params[:propoz][:filename]
    if uploaded_io.present? 
      file_delete propoz.filename
      filename = 'propoz_'+DateTime.now.strftime("%Y%m%d%H%M%S").to_s+File.extname(uploaded_io.original_filename).to_s
      path = Rails.root.join('public', 'uploads', 'propoz')
      filename_path = Rails.root.join('public', 'uploads', 'propoz', filename)
      File.open(filename_path, 'wb') do |file|
       file.write(uploaded_io.read)
      end
      propoz.update(filename: filename)
      filename_html = convert_to_html filename_path,path
      filename_path_html = Rails.root.join('public', 'uploads', 'propoz', filename_html)
      if File.file?(filename_path_html)
        propoz.update(html: filename_html)
      end
    end
end

def file_delete filename
    
    if filename.present?
      file_path = Rails.root.join('public', 'uploads', 'propoz', filename)
      files=[]
      files << file_path
      files << (File.dirname(file_path).to_s + "/" + File.basename(file_path,'.*').to_s + '.html')

      #puts YAML::dump(files)
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