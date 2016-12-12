class User < ApplicationRecord
  has_secure_password

  has_many :favorites
  has_many :reviews

  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
end
