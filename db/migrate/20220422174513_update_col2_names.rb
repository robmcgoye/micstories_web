class UpdateCol2Names < ActiveRecord::Migration[6.1]
  def change
    rename_column :stories, :title_long, :long_title
    rename_column :stories, :title_short, :short_title
  end
end
