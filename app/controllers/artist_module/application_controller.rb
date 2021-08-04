module ArtistModule
  class ApplicationController < ::ApplicationController
    before_action :authorize_artist

    private

    def authorize_artist
      session[:return_to] = request.referrer || root_path
      redirect_to root_path, warning: 'Please log back in to your account to continue.' if current_artist.nil?
    end
  end
end
