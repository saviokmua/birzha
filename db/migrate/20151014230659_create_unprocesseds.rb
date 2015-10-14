class CreateUnprocesseds < ActiveRecord::Migration
  def change
    create_table :unprocesseds do |t|
      t.string :title
      t.text :content
      t.integer :visible
      t.string :filename
      t.timestamps null: false
    end
  end
end
