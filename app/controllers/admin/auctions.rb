class Admin::AuctionsController < AdminController
  def index
    @auctions=auctions.all
  end
end

