module Admin
  class ArtworksController < Admin::ApplicationController
    before_action :set_artist
    before_action :set_artwork, except: %i[index new create]

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

    def destroy
      series = Series.by_artwork(@artwork.id)
      if series.present?
        @artwork.errors.add(:base, "Artwork connected to series. Remove the artwork from #{series.pluck(:title).join(', ')} before attempting deletion.")
        redirect_to admin_artist_path(@artist), danger: artwork_errors
      else
        @artwork.destroy
        redirect_to admin_artist_path(@artist), success: "Artwork successfully deleted"
      end
    end

    private

    def set_artist
      @artist = Artist.friendly.find(params[:artist_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_artists_path, warning: "Artist not found."
    end

    def set_artwork
      @artwork = @artist.artworks.find_by(id: params[:id])
      redirect_to admin_artist_path(@artist), warning: "Artwork not found." unless @artwork.present?
    end

    def artwork_params
      params.require(:artwork).permit(
        :file,
        :title,
        :medium,
        :measurements,
        :description,
        :status,
        :notes,
        :price
      )
    end

    def artwork_errors
      @artwork.errors.full_messages.join(', ')
    end
  end
end
