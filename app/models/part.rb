class Part < ApplicationRecord
  belongs_to :chapter
  has_many :chats
  accepts_nested_attributes_for :chats, allow_destroy: true

  validates :title, presence: true
  validates :chat_title, presence: true
  validates :content, presence: true
  validates :sort_order, numericality: true
  validates_date :publish_at, on: :create, on_or_after: :today
end