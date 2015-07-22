class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :name
      t.datetime :started_at
      t.integer :category_id
      t.integer :status_id
      t.string :filename
      t.float :cina
 
      t.timestamps null: false
    end
  end
end
