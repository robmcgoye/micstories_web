class UpdateColNames < ActiveRecord::Migration[6.1]
  def change
    rename_column :parts, :publish_date, :publish_at
    rename_column :chats, :publish_date, :publish_at
  end
end
