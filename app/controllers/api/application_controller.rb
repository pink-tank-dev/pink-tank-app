module Api
  class ApplicationController < ActionController::API
    def error(message, status)
      render json: { message: message, status: status }, status: status
    end
  end
end
