class FavoritesController < ApplicationController
  before_action :find_movie, only: [:new, :create]

  def new
    if logged_in?
     @favorite = Favorite.new
   else
     redirect_to new_session_path
   end
  end

  def create
    if logged_in?
      @favorite = @movie.favorites.create
      @favorite.user_id = current_user.id
      if @favorite.save
        redirect_to movie_path(@movie)
    else
    redirect_to new_session_path
  end
end

  private
    def find_movie
      @movie = Movie.find(params[:movie_id])
    end
end
