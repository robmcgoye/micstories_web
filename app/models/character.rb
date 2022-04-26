class Character < ApplicationRecord
  has_many :chats
  accepts_nested_attributes_for :chats, allow_destroy: true
  
  validates :chat_name, presence: true
  validates :sort_order, numericality: true
end