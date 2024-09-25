class User < ApplicationRecord
  has_many :guitars
  has_secure_password
  validates :email, presence: true, uniqueness: true
end
