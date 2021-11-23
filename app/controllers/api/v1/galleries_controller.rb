module Api
  module V1
    class GalleriesController < Api::ApplicationController
      def show
        series = Exhibition.current.last.series.includes(:artist).order('artists.name asc')
        @total = series.size
        @series = Kaminari.paginate_array(series).page(page).per(limit)
      end

      def artwork
        return error('Artwork ID not provided', 400) unless params[:artwork_id]

        @series = Series.includes(:artist).by_artwork(params[:artwork_id]).last
        return error('Artwork series not found', 404) unless @series
      end
    end
  end
end
