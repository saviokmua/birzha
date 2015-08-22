class AddAuctionidToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :auction_id,  :integer
    add_column :articles, :auction_enable,  :boolean, default: false
  
  end
end
