class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_secure_password

  VALID_EMAIL_REGEX = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  validates :name, presence: true, 
                    length: { minimum: 3, maximum: 100 }
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false }, 
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

end
