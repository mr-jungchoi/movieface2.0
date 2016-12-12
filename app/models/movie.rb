class Movie < ApplicationRecord
  validates_presence_of :youtube_trailer_id, :title, :year, :director, :writer, :plot
  validates_uniqueness_of :youtube_trailer_id
  belongs_to :genre
  has_many :favorites
  has_many :reviews


  def self.parse(youtube_response, omdb_response)
    youtube_hash = JSON.parse(youtube_response)
    omdb_hash = JSON.parse(omdb_response)
    youtube_id = youtube_hash["items"][0]["id"]["videoId"]

    self.new(title: omdb_hash["Title"],
             youtube_trailer_id: youtube_id,
             year: omdb_hash["Year"],
             rated: omdb_hash["Rated"],
             runtime: omdb_hash["Runtime"],
             director: omdb_hash["Director"],
             writer: omdb_hash["Writer"],
             actors: omdb_hash["Actors"],
             plot: omdb_hash["Plot"])
  end
end
