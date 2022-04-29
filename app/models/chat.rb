class Chat < ApplicationRecord
  belongs_to :part
  belongs_to :character

  validates :post, presence: true
  validates :sort_order, numericality: true
  validates :publish_at, presence: true, on_or_after_today: true

end