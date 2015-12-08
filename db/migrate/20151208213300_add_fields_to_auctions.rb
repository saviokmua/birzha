class AddFieldsToAuctions < ActiveRecord::Migration
  def change
    
    add_column :auctions, :started_time_at,  :string
    add_column :auctions, :details,  :text
  
  end
end
