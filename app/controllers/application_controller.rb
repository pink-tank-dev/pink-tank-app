class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  helper_method :logged_in?, :current_user
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if logged_in?
  end
end
