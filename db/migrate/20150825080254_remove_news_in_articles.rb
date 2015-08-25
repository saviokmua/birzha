class RemoveNewsInArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :news
  end
end
