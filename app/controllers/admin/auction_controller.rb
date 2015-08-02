class Admin::AuctionController < AdminController

  before_action :get_auction, only: [:edit,:update,:file_download,:get_filename_origin]
  before_action :get_order, only: [:index]


  def index
   	per_page = 4
  	params[:page]||=1
  	@start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
    @auctions = Auction.search(params[:search]).paginate(page: params[:page], per_page: per_page).includes(:status).includes(:category).order(params[:search][:order])
  end

  def new
  	@auction = Auction.new
    @status = Status.all
    @category = Category.all
  end

  
  def create
  	@auction = Auction.new(auction_params)
  	if @auction.save
  		flash[:success] = 'Створено новий запис'
      redirect_to admin_auction_index_path
  	else
  		flash[:error] = 'Помилка створення нового запису'
      render "new"
  	end
  end

  
  def update
    if @auction.update(auction_params)
      flash[:success] = 'Запис успішно збережений'
      file_upload params[:id]
      redirect_to admin_auction_index_path 
 	  else
  		flash[:error] = 'Помилка збереження запису'
      render 'edit'
  	end
  end

  def destroy
  	@auction = Auction.find_by(id: params[:id])
  	if @auction.destroy
  		flash[:notice] = 'Знищено запис'
  	end
    redirect_to admin_auction_index_path
  end

def file_destroy
    file_delete params[:auction_id]
    @auction=Auction.find(params[:auction_id])
    respond_to do |format|
      format.html { redirect_to admin_auction_path(params[:auction_id]) }
      format.js
      format.json 
    end    
  end

def file_download
  send_file(Rails.root.join('public', 'uploads',@auction.filename),filename: @auction.filename_origin)
end

private

  def auction_params
      params.require(:auction).permit(:name,:started_at,:category_id,:status_id,:cina)
  end

  def file_upload id
    uploaded_io = params[:auction][:file]
    if uploaded_io.present? 
      file_delete id
      filename=id.to_s+'_'+uploaded_io.original_filename
      File.open(Rails.root.join('public', 'uploads', filename), 'wb') do |file|
      file.write(uploaded_io.read)
      end
      Auction.update(id,filename: filename)
    end
  end

  def file_delete id
    @auction=Auction.find_by(id: id)
    if @auction.filename.present? 
      file_path = Rails.root.join('public', 'uploads', @auction.filename)
      if File.file?(file_path) 
        File.delete(file_path)
        Auction.update(id,filename: nil) 
      end
    end
  end

  def get_auction
    @auction = Auction.find(params[:id])
  end

  def get_order
    if !params[:search].present?
      params[:search]={}
      params[:search][:order]="started_at DESC"
    end
    
  end



end