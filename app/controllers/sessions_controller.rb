class SessionsController < ApplicationController
  def new
    return unless current_user.present?

    redirect_to artists_path
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to artists_path
    else
      flash[:warning] = 'Something went wrong! Make sure your name and password are correct.'
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    @current_user = nil
    redirect_to root_path
  end
end
