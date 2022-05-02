class Story < ApplicationRecord
  has_many :chapters
  has_many :characters
  accepts_nested_attributes_for :chapters, allow_destroy: true
  accepts_nested_attributes_for :characters, allow_destroy: true

  mount_uploader :header_picture, ImagesUploader 

  validates :long_title, presence: true
  validates :short_title, presence: true, length: {maximum: 25}
  validates :sort_order, numericality: true

  default_scope { order(sort_order: :asc) }

  scope :published_stories, -> { where("published = :published", {published: true}) }

end