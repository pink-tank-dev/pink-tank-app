module Api
  module V1
    class ContactUsController < Api::ApplicationController
      def create
        ContactUsMailer.with(contact_us_params).send_email.deliver_later
      end

      private

      def contact_us_params
        params.require(:contact_u).permit(:name, :email, :subject, :message)
      end
    end
  end
end
