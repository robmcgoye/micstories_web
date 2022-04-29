class Part < ApplicationRecord
  belongs_to :chapter
  has_many :chats
  accepts_nested_attributes_for :chats, allow_destroy: true

  validates :title, presence: true
  validates :chat_title, presence: true
  validates :content, presence: true
  validates :publish_at, presence: true, on_or_after_today: true
  validates :sort_order, numericality: true

end