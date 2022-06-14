class Setting < ApplicationRecord
  validates :default_description, length: {maximum: 165}

end