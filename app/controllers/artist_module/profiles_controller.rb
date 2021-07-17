module ArtistModule
  class ProfilesController < ::ApplicationController
    before_action :set_artist, only: %i[edit update]
    def show
      @posts = current_artist.posts.with_rich_text_body.order(created_at: :asc)
    end

    def edit; end

    def update
      @artist.assign_attributes(artist_params)
      if @artist.save
        redirect_to artist_module_profile_path, success: "#{@artist.name} successfully updated."
      else
        flash[:danger] = artist_errors
        render :edit
      end
    end

    private

    def set_artist
      @artist = Artist.find_by(id: current_artist.id)
    end

    def artist_params
      params.require(:artist).permit(:name, :email, :about)
    end
  end
end
