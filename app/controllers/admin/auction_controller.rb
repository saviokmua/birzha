class Admin::AuctionController < AdminController
  def index
  	#@articles = Article.all
  	per_page = 15
  	params[:page]||=1
  	@start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
  	@auctions = Auction.paginate(page: params[:page], per_page: per_page).order('name	ASC')
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
  		flash[:error] = 'Помилка створення нового запису'+@auction.errors.full_messages.to_s
      render "new"
  	end
  end

  def edit
  	@auction = Auction.find_by(id: params[:id])
  end

  def update
	@auction = Auction.find_by(id: params[:id])  	
	if @auction.update(auction_params)
        flash[:success] = 'Запис успішно збережений'
        
        uploaded_io = params[:picture]
  File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
  end


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
      redirect_to admin_auction_index_path
  	end
  end

private
 def auction_params
      params.require(:auction).permit(:name,:started_at,:category_id,:status_id,:filename,:cina)
 end


end
