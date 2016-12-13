class FavoritesController < ApplicationController
  before_action :find_movie, only: [:new, :create]

  def create
  
    @favorite = @movie.favorites.create
    @favorite.user_id = current_user.id
    if @favorite.save
      redirect_to movie_path(@movie)
    else
      render 'new'
    end
  end

  private
    def find_movie
      @movie = Movie.find(params[:movie_id])
    end
end
