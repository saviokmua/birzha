class ModifyResult < ActiveRecord::Migration
  def change
    
    change_table :results do |t|
      t.change :date, :timestamp
    end
  
  end
end
