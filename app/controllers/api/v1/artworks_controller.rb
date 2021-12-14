module Api
  module V1
    class ArtworksController < Api::ApplicationController
      before_action :set_artwork
      SHIPPING = 'shipping'.freeze
      PICKUP = 'pickup'.freeze
      DELIVERY_METHODS = [SHIPPING, PICKUP].freeze
      PAYMENT_METHODS = ['installments', 'buy_now'].freeze

      def show; end

      private

      def set_artwork
        @artwork = Artwork.find_by(id: params[:id])
        return error('Artwork not found', 404) unless @artwork
      end
    end
  end
end
