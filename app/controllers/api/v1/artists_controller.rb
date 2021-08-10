module Api
  module V1
    class ArtistsController < Api::ApplicationController
      before_action :set_artist, only: %i[show]

      def index
        @artists = Artist.active.order(name: :asc)
      end

      def show
        @posts = @artist.posts.with_rich_text_body_and_embeds.published.order(published_at: :asc)
      end

      private

      def set_artist
        @artist = Artist.find_by(id: params[:id])

        return error("Artist not found", 404) unless @artist
      end
    end
  end
end
