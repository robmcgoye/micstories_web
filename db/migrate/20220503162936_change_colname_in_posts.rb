class ChangeColnameInPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :post, :message
  end
end
