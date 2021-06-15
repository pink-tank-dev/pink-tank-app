module Api
  module V1
    class ArtistsController < Api::ApplicationController
      def index
        @artists = Artist.all
      end
    end
  end
end
