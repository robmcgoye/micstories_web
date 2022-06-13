class Part < ApplicationRecord
  belongs_to :chapter
  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :posts, allow_destroy: true

  validates :title, presence: true
  validates :chat_title, presence: true
  validates :content, presence: true
  validates :publish_at, presence: true, on_or_after_today: true, on: :create
  validates :sort_order, numericality: true, uniqueness: { scope: :chapter_id, message: "This sort # has already been chosen." }

  default_scope { order(sort_order: :asc) }

  scope :published_part, -> (id) { joins(:chapter).where(
    "parts.id = :id AND stories.published = :published AND parts.published = :published AND parts.publish_at <= :today", 
    {id: id, published: true, today: Date.today}) }
    
  scope :published_parts, ->(story_id) { joins(:chapter).where( 
    "chapters.story_id = :story_id AND parts.published = :published AND parts.publish_at <= :today", 
    {story_id: story_id, published: true, today: Date.today} ) }

  def self.next_part( chapter_id, sort_order, admin ) 
    if admin
      where( "parts.chapter_id = :chapter_id AND parts.sort_order > :sort_order", 
        {chapter_id: chapter_id, sort_order: sort_order} ).limit(1)
    else
      where( "parts.chapter_id = :chapter_id AND parts.sort_order > :sort_order AND parts.published = :published AND parts.publish_at <= :today", 
        {chapter_id: chapter_id, sort_order: sort_order, published: true, today: Date.today} ).limit(1)
    end
  end
  
  def self.first_part( chapter_id, admin )
    if admin
      where( "parts.chapter_id = :chapter_id", {chapter_id: chapter_id} ).first
    else
      where( "parts.chapter_id = :chapter_id AND parts.published = :published AND parts.publish_at <= :today",
        {chapter_id: chapter_id, published: true, today: Date.today} ).first
    end
  end

  def self.last_part( chapter_id, admin )
    if admin
      where( "parts.chapter_id = :chapter_id", {chapter_id: chapter_id} ).last
    else
      where( "parts.chapter_id = :chapter_id AND parts.published = :published AND parts.publish_at <= :today", 
        {chapter_id: chapter_id, published: true, today: Date.today} ).last
    end
  end
          
  def self.prev_part( chapter_id, sort_order, admin )
    if admin
      unscope(:order).where( "parts.chapter_id = :chapter_id AND parts.sort_order < :sort_order", 
        {chapter_id: chapter_id, sort_order: sort_order} ).order(sort_order: :desc).limit(1)
    else
      unscope(:order).where( 
        "parts.chapter_id = :chapter_id AND parts.sort_order < :sort_order AND parts.published = :published AND parts.publish_at <= :today", 
        {chapter_id: chapter_id, sort_order: sort_order, published: true, today: Date.today} ).order(sort_order: :desc).limit(1)
    end
  end
  
end