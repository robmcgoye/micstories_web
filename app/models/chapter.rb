class Chapter < ApplicationRecord
  belongs_to :story
  has_many :parts
  accepts_nested_attributes_for :parts, allow_destroy: true

  validates :title, presence: true
  validates :sort_order, numericality: true

  default_scope { order(sort_order: :asc) }
  
end