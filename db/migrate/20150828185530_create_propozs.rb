class CreatePropozs < ActiveRecord::Migration
  def change
    create_table :propozs do |t|
      t.text :title
      t.text :filename
      t.text :html
      t.boolean :type, default: false
      t.boolean :enable, default: false
      t.timestamps null: false
    end
  end
end
