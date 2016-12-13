class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :user, uniqueness: true
end
