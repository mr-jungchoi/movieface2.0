class ReviewsController < ApplicationController
  before_action :find_movie, only: [:show, :new, :create, :edit, :destroy]

  def new
    @review = Review.new
  end

  def show
    @review = @movie.reviews.find_by_id(params[:id])
  end

  def create
    @review = @movie.reviews.create(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to movie_path(@movie)
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
    @review = @movie.reviews.create(review_params)
    @review.destroy
    redirect_to movie_path(@movie)
  end

  private
    def review_params
      params.require(:review).permit(:user, :content, :rating)
    end

    def find_movie
      @movie = Movie.find(params[:movie_id])
    end
end
