class Chapter < ApplicationRecord
  belongs_to :story
  has_many :parts, dependent: :destroy
  accepts_nested_attributes_for :parts, allow_destroy: true

  validates :title, presence: true
  validates :sort_order, numericality: true, uniqueness: { scope: :story_id, message: "This sort # has already been chosen." }

  default_scope { order(sort_order: :asc) }

  scope :next_chapter, -> (story_id, sort_order) { where(
    "chapters.story_id = :story_id AND chapters.sort_order > :sort_order", 
    {story_id: story_id, sort_order: sort_order}).limit(1)}

  scope :prev_chapter, -> (story_id, sort_order) { unscope(:order).where(
      "chapters.story_id = :story_id AND chapters.sort_order < :sort_order", 
      {story_id: story_id, sort_order: sort_order}).order(sort_order: :desc).limit(1)}
  
end