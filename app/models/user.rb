class User < ApplicationRecord
  has_secure_password 
  validates :email, presence:true, uniquness:true 
end
