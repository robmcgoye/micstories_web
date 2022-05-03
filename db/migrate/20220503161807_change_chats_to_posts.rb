class ChangeChatsToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_table :chats, :posts
  end
end
