module Api
  class ApplicationController < ActionController::API
    include ActionController::Caching

    helper_method :page, :limit

    def error(message, status)
      render json: { message: message, status: status }, status: status
    end

    def page
      (params[:page] || 1).to_i
    end

    def limit
      (params[:limit] || 10).to_i
    end
  end
end
