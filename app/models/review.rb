class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates_uniqueness_of :user, scope: :movie_id
end
