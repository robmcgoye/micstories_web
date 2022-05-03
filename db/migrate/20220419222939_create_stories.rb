class CreateStories < ActiveRecord::Migration[6.1]
  def change
    create_table :stories do |t|
      t.string :title_long
      t.string :title_short
      t.string :header_picture
      t.boolean :published
      t.string :author
      t.integer :sort_order

      t.timestamps
    end

    create_table :chapters do |t|
      t.references :story, null: false, foreign_key: true
      t.string :title
      t.string :subtitle
      t.integer :sort_order
      t.timestamps
    end

    create_table :parts do |t|
      t.references :chapter, null: false, foreign_key: true
      t.string :title
      t.string :subtitle
      t.string :chat_title
      t.boolean :published
      t.text :content
      t.integer :sort_order
      t.datetime :publish_date
      t.timestamps
    end

    create_table :characters do |t|
      t.string :full_name
      t.string :chat_name
      t.text :description
      t.integer :sort_order
      t.timestamps
    end
    
    create_table :chats do |t|
      t.references :part, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.boolean :published
      t.datetime :publish_date
      t.integer :sort_order
      t.text :post
      t.timestamps
    end
  end
end
