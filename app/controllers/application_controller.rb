class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :movie_reviewed?, :movie_favorited?

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
      if @movie.id == review.movie_id
        return true
      else
        return false
      end
    end
  end

  def movie_favorited?
    @current_user.favorites.each do |favorite|
      if @movie.id == favorite.movie_id
        return true
      else
        return false
      end
    end
  end

  protect_from_forgery with: :exception
end
