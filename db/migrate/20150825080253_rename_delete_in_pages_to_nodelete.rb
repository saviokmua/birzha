class RenameDeleteInPagesToNodelete < ActiveRecord::Migration
  def change
    rename_column :pages, :delete, :nodelete
  end
end
