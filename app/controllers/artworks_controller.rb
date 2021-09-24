class ArtworksController < ApplicationController
  def index
    return error("Artist ID not provided", 400) unless params[:artist_id].present?
    render json: Artwork.by_artist(params[:artist_id]).select(:title, :id), status: 200
  end
end
