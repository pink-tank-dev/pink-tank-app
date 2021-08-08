module ArtistModule
  class ProfilesController < ApplicationController
    before_action :set_artist, except: %i[show]

    def show
      @posts = current_artist.posts.with_rich_text_body.order(created_at: :asc)
    end

    def edit; end

    def edit_password; end

    def update
      @artist.assign_attributes(update_params)
      if @artist.save
        redirect_to artist_module_profile_path, success: "#{@artist.name} successfully updated."
      else
        flash[:danger] = artist_errors
        render :edit
      end
    end

    def update_password
      @artist.assign_attributes(update_password_params)
      if @artist.save
        redirect_to artist_module_profile_path, success: "Password successfully updated."
      else
        flash[:danger] = artist_errors
        render :edit_password
      end
    end

    private

    def set_artist
      @artist = Artist.find_by(id: current_artist.id)
    end

    def update_params
      params.require(:artist).permit(:avatar, :name, :email, :instagram, :about, :statement)
    end

    def update_password_params
      params.require(:artist).permit(:password, :password_confirmation)
    end

    def artist_errors
      @artist.errors.full_messages.join(', ')
    end
  end
end
