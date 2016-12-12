class Genre < ApplicationRecord
  has_many :movies

  def self.parse(omdb_response)
    omdb_hash = JSON.parse(omdb_response)
    genres = omdb_hash["Genre"].split(",")
    self.new(name: genres.first)
  end
end
