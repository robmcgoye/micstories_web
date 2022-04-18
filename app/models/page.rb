class Page < ApplicationRecord
  validates :body, presence: true
  validates :name, presence: true, 
  uniqueness: { case_sensitive: false }, 
  length: { minimum: 2, maximum: 50 }  
end
