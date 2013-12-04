module Api
  module V1
    class ResponsesController < ApiApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        respond_with Response.create(params[:response])
      end
    end
  end
end
