require 'open-uri'

class MoviesController < ApplicationController
  def index
  end

  def show
    @movie = Movie.find_by_id(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    search_keyword = params[:query]
    @movie = Movie.find_partial(search_keyword)

    if @movie
      redirect_to movie_path(@movie)
    else
      omdb_response = open(omdb_url + search_keyword).read
      # error handling not working
      # if omdb_response["Response"] == "True"
        youtube_response = open(youtube_url + trailer_search(search_keyword) + youtube_token).read
        @movie = Movie.parse(youtube_response, omdb_response)
        genre = Genre.parse(omdb_response)
        @genre = Genre.find_or_create_by(name: genre.name)
        @movie.genre = @genre
        @movie.save
        redirect_to movie_path(@movie)
      # else
      #   flash[:error] = ["Your movie doesn't exist"]
      # end
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :youtube_trailer_id, :imdb_id)
  end

  def youtube_url
    "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&q="
  end

  def omdb_url
    "http://www.omdbapi.com/?y=&plot=short&r=json&t="
  end

  def trailer_search(movie_name)
    "#{movie_name}+trailer"
  end
end
