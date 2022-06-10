class Part < ApplicationRecord
  belongs_to :chapter
  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :posts, allow_destroy: true

  validates :title, presence: true
  validates :chat_title, presence: true
  validates :content, presence: true
  validates :publish_at, presence: true, on_or_after_today: true, on: :create
  validates :sort_order, numericality: true

  default_scope { order(sort_order: :asc) }

  scope :published_part, ->(id) { joins(chapter: :story).where(
    "parts.id = :id AND stories.published = :published AND parts.published = :published AND parts.publish_at <= :today", 
    {id: id, published: true, today: Date.today}) }

  scope :published_parts, -> { where( "parts.published = :published AND parts.publish_at <= :today", 
    {published: true, today: Date.today} ) }
end