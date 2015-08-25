class AuctionController < ApplicationController

  before_action :get_auction, only: [:show,:download]

  def index
   	per_page = 25
  	params[:page]||=1
  	@start_num = (per_page.to_i * (params[:page].to_i-1)).to_i
    @auctions = Auction.paginate(page: params[:page], per_page: per_page).includes(:status).includes(:category).order("started_at DESC")
  end
  
def download
    send_file(Rails.root.join('public', 'uploads',@auction.filename),filename: @auction.filename_origin)
  end


private

  def auction_params
      params.require(:auction).permit(:id)
  end

  

  def get_auction
    @auction = Auction.find(params[:id])
  end

  

end