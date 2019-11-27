class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email

  has_many :products
  has_many :votes
end
