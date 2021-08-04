class SessionsController < ApplicationController
  def new
    return unless current_user.present? || current_artist.present?

    _path = begin
              if current_user.present?
                admin_artists_path
              elsif current_artist.present?
                artist_module_profile_path
              end
            end
    redirect_to _path
  end

  def login_user
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to admin_artists_path
    else
      flash[:warning] = 'Something went wrong! Make sure your email and password are correct.'
      redirect_to root_path
    end
  end

  def logout_user
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path
  end

  def login_artist
    @artist = Artist.find_by(email: params[:email])

    if @artist&.authenticate(params[:password])
      session[:artist_id] = @artist.id
      redirect_to artist_module_profile_path
    else
      flash[:warning] = 'Something went wrong! Make sure your email and password are correct.'
      redirect_to root_path
    end
  end

  def logout_artist
    session[:artist_id] = nil
    @current_artist = nil
    redirect_to root_path
  end
end
