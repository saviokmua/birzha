class RemoveTypeInPropoz < ActiveRecord::Migration
  def change
    remove_column :propozs, :type
  end
end
