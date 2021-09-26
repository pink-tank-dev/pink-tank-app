class ArtworksController < ApplicationController
  before_action :set_artwork, only: %i[move]

  def index
    return error("Artist ID not provided", 400) unless params[:artist_id].present?
    render json: Artwork.by_artist(params[:artist_id]).select(:title, :id), status: 200
  end

  def move
    @artwork.insert_at(params[:position].to_i)
    head :ok
  end

  private

  def set_artwork
    @artwork = Artwork.find_by(id: params[:id])
  end
end
