module Api
  module Metaverse
    class ArtistsController < Api::ApplicationController
      def show
        @artist = Artist.find_by(id: params[:id])
        return error("Artist not found", 404) unless @artist.present?
      end
    end
  end
end
