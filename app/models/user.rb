class User < ApplicationRecord
  # attributes
  has_secure_password
  validates :email, presence: true, uniqueness: true

  # relationships
  has_many :posts
  has_many :comments
end
