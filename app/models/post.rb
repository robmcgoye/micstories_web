class Post < ApplicationRecord
  belongs_to :part
  belongs_to :character

  validates :message, presence: true
  validates :sort_order, numericality: true
  validates :publish_at, presence: true, on_or_after_today: true, on: :create
  validates :character, presence: true
  
  default_scope { order(sort_order: :asc) }
  
end