class AddDocumentsToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :documents, :text
  end
end
