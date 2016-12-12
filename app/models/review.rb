class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
end
