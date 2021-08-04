module Admin
  class ApplicationController < ::ApplicationController
    before_action :authorize_user

    private

    def authorize_user
      session[:return_to] = request.referrer || root_path
      redirect_to root_path, warning: 'Please log back in to your account to continue.' if current_user.nil?
    end
  end
end
