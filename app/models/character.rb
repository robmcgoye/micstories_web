class Character < ApplicationRecord
  belongs_to :story
  has_many :chats
  accepts_nested_attributes_for :chats, allow_destroy: true
  
  validates :chat_name, presence: true
  validates :sort_order, numericality: true

  default_scope { order(sort_order: :asc) }
  
end