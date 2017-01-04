class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :movie_reviewed?, :movie_favorited?, :movie_genre

  def youtube_token
    @youtube_token ||= "&key=#{Dotenv.load["YOUTUBE_TOKEN"]}"
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def movie_reviewed?
    @current_user.reviews.each do |review|
      return true if @movie.id == review.movie_id
    end
    false
  end

  def movie_favorited?
    @current_user.favorites.each do |favorite|
      return true if @movie.id == favorite.movie_id
    end
    false
  end

  def movie_genre
    @genre = Genre.find_by_id(@movie.genre_id)
  end

  protect_from_forgery with: :exception
end
