class AddTextToAuctions < ActiveRecord::Migration
  def change
    
    add_column :auctions, :content,  :text
  
  end
end
