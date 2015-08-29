class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.text :title
      t.text :filename
      t.text :html
      t.date :date
      t.boolean :enable, default: false
      t.timestamps null: false
    end
  end
end
