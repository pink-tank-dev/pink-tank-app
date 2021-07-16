module Admin
  class SessionsController < ApplicationController
    def create
      @user = User.find_by(email: params[:email])

      if @user&.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to admin_artists_path
      else
        flash[:warning] = 'Something went wrong! Make sure your email and password are correct.'
        redirect_to root_path
      end
    end

    def destroy
      session[:user_id] = nil
      @current_user = nil
      redirect_to root_path
    end
  end
end
