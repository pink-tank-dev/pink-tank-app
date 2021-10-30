module Api
  module Metaverse
    class VisitorsController < Api::ApplicationController
      def create
        return error("Visitor name and email not provided.", 400) unless params[:name].present? && params[:email].present?
        AppendVisitorsSheetWorker.perform_async(params[:name], params[:email])
      end

      def thank_you
        return error("Visitor name and email not provided.", 400) unless params[:name].present? && params[:email].present?
        SendThankYouWorker.perform_async(params[:name], params[:email])
      end
    end
  end
end
