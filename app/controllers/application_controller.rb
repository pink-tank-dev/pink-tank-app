class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  helper_method :user_logged_in?, :current_user, :artist_logged_in?, :current_artist
  def user_logged_in?
    !!session[:user_id]
  end

  def artist_logged_in?
    !!session[:artist_id]
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if user_logged_in?
  end

  def current_artist
    @current_artist ||= Artist.find_by(id: session[:artist_id]) if artist_logged_in?
  end
end
