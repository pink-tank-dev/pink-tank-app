module Api
  module Metaverse
    class VisitorsController < Api::ApplicationController
      include Gcp::WorkspaceService

      def create
        return error("Visitor name and email not provided", 400) unless params[:name].present? && params[:email].present?
        AppendVisitorsSheetWorker.perform_async(params[:name], params[:email])
      end

      def send_email
      end
    end
  end
end
