class Character < ApplicationRecord
  belongs_to :story
  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :posts, allow_destroy: true
  
  validates :chat_name, presence: true
  validates :sort_order, numericality: true

  default_scope { order(sort_order: :asc) }
  
  scope :from_story, ->(story_id) { joins(:story).where("stories.id = :id", {id: story_id}) }
end