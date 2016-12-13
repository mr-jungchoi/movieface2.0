class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :capitalize_search,

  def youtube_token
    @youtube_token ||= "&key=#{Dotenv.load["YOUTUBE_TOKEN"]}"
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  protect_from_forgery with: :exception
end
