class ReviewsController < ApplicationController
  before_action :find_movie, only: [:show, :new, :create, :edit, :destroy]

  def new
    if logged_in?
      @review = Review.new
    else
      redirect_to new_session_path
    end
  end

  def show
    @review = @movie.reviews.find_by_id(params[:id])
  end

  def create
    if logged_in?
      @review = @movie.reviews.create(review_params)
      @review.user_id = current_user.id
      if @review.save
        redirect_to movie_path(@movie)
      else
        render 'new'
      end
    else
      redirect_to new_session_path
    end
  end

  def edit
  end

  def destroy
    if logged_in?
      @review = @movie.reviews.create(review_params)
      @review.destroy
      redirect_to movie_path(@movie)
    else
      redirect_to new_session_path
    end
  end

  private
    def review_params
      params.require(:review).permit(:user, :content, :rating)
    end

    def find_movie
      @movie = Movie.find(params[:movie_id])
    end
end
