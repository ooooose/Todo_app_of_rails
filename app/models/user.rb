class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: {maximum: 20}
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }
end
