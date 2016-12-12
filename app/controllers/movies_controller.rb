class MoviesController < ApplicationController
  def index
  end

  def show
    search_keyword = params[:search]
    youtube_response = open(youtube_url + search_keyword + trailer_search(search_keyword) + youtube_token).read
    omdb_response = open(omdb_url + search_keyword).read

    @movie = Movie.parse(youtube_response, omdb_response)
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :youtube_trailer_id, :imdb_id)
  end

  def youtube_url
    "https://www.googleapis.com/youtube/v3/search?part=snippet&q="
  end

  def omdb_url
    "http://www.omdbapi.com/?y=&plot=short&r=json&t="
  end

  def trailer_search(movie_name)
    "#{movie_name}+trailer"
  end
end
