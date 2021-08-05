module Api
  module V1
    class ContactUsController < Api::ApplicationController
      def create
        ContactUsMailer.send_email(name: contact_us_params[:name],
                                   email: contact_us_params[:email],
                                   subject: contact_us_params[:subject],
                                   message: contact_us_params[:message]).deliver_later
      end

      private

      def contact_us_params
        params.require(:contact_u).permit(:name, :email, :subject, :message)
      end
    end
  end
end
