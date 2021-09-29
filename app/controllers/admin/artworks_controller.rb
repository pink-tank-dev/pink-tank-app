module Admin
  class ArtworksController < Admin::ApplicationController
    before_action :set_artist
    before_action :redirect_if_artist_not_found, only: %i[new edit show]
    before_action :set_artwork, except: %i[index new create]
    before_action :redirect_if_artwork_not_found, only: %i[edit show]

    def new
      @artwork = Artwork.new
    end

    def create
      @artwork = Artwork.new(artwork_params.merge(artist: @artist))
      if @artwork.save
        redirect_to admin_artist_artwork_path(@artist, @artwork), success: "Artwork successfully created."
      else
        flash[:danger] = artwork_errors
        render :new
      end
    end

    def edit; end

    def update
      @artwork.assign_attributes(artwork_params)
      if @artwork.save
        redirect_to admin_artist_artwork_path(@artist, @artwork), success: "Artwork successfully updated."
      else
        flash[:danger] = artwork_errors
        render :edit
      end
    end

    def show; end

    private

    def set_artist
      @artist = Artist.find_by(id: params[:artist_id])
    end

    def redirect_if_artist_not_found
      redirect_to admin_artists_path, warning: "Artist not found." unless @artist.present?
    end

    def set_artwork
      @artwork = Artwork.find_by(id: params[:id])
    end

    def redirect_if_artwork_not_found
      redirect_to admin_artist_artworks_path(@artist), warning: "Artwork not found." unless @artwork.present?
    end

    def artwork_params
      params.require(:artwork).permit(
        :file,
        :title,
        :medium,
        :measurements,
        :description,
      )
    end

    def artwork_errors
      @artwork.errors.full_messages.join(', ')
    end
  end
end
