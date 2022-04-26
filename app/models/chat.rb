class Chat < ApplicationRecord
  belongs_to :part
  belongs_to :character

  validates :post, presence: true
  validates :sort_order, numericality: true
  validates_date :publish_at, on: :create, on_or_after: :today

end