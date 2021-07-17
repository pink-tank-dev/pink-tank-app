module ArtistModule
  class SessionsController < ::ApplicationController
    def create
      @artist = Artist.find_by(email: params[:email])

      if @artist&.authenticate(params[:password])
        session[:artist_id] = @artist.id
        redirect_to artist_module_profile_path
      else
        flash[:warning] = 'Something went wrong! Make sure your email and password are correct.'
        redirect_to root_path
      end
    end

    def destroy
      session[:artist_id] = nil
      @current_artist = nil
      redirect_to root_path
    end
  end
end
