class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.integer :spotlight_story_id
      t.string :default_description

      t.timestamps
    end
  end
end
