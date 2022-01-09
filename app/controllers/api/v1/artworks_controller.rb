module Api
  module V1
    class ArtworksController < Api::ApplicationController
      before_action :set_artwork
      SHIPPING = 'shipping'.freeze
      PICKUP = 'pickup'.freeze
      DELIVERY_METHODS = [SHIPPING, PICKUP].freeze
      PAYMENT_METHODS = ['installments', 'buy_now'].freeze

      def show; end

      def acquire
        return error("Delivery method not specified: ['shipping', 'pickup']", 400) unless delivery_method_defined?
        return error("Payment method not specified: ['installments', 'buy_now']", 400) unless payment_method_defined?
        return error("Shipping information incomplete", 400) unless shipping_params_provided?
        return error("Pickup information incomplete", 400) unless pickup_params_provided?

        SendAcquireInvoiceWorker.perform_async(acquire_params.merge(artwork_id: @artwork.id))

        head :no_content
      end

      private

      def set_artwork
        @artwork = Artwork.find_by(id: params[:id])
        return error('Artwork not found', 404) unless @artwork
      end

      def delivery_method_defined?
        delivery_method = acquire_params[:delivery_method]
        delivery_method.present? && DELIVERY_METHODS.include?(delivery_method)
      end

      def payment_method_defined?
        payment_method = acquire_params[:payment_method]
        payment_method.present? && PAYMENT_METHODS.include?(payment_method)
      end

      def shipping_params_provided?
        return true unless shipping?
        shipping_params = [:name, :email, :phone, :address_1, :city, :postal_code, :state, :country]
        shipping_params.all? { |k| acquire_params.has_key?(k) }
      end

      def pickup_params_provided?
        return true unless pickup?
        pickup_params = [:email, :phone]
        pickup_params.all? { |k| acquire_params.has_key?(k) }
      end

      def shipping?
        acquire_params[:delivery_method].present? && acquire_params[:delivery_method] == SHIPPING
      end

      def pickup?
        acquire_params[:delivery_method].present? && acquire_params[:delivery_method] == PICKUP
      end

      def acquire_params
        params.require(:acquire).permit(
          :delivery_method,
          :payment_method,
          :name,
          :email,
          :phone,
          :address_1,
          :address_2,
          :city,
          :postal_code,
          :state,
          :country
        )
      end
    end
  end
end
