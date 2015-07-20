class AddNewsToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :news, :boolean, default: false
  end
end
