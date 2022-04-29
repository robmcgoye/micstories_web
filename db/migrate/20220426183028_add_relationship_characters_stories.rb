class AddRelationshipCharactersStories < ActiveRecord::Migration[6.1]
  def change
    add_reference :characters, :story, foreign_key: true
  end
end
