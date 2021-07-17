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
end
