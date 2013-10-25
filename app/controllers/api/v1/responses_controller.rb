module Api
  module V1
    class ResponsesController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        respond_with Response.create(response_params)
      end

      private
      def response_params
        # TODO add fields to permit
        params.require(:response).permit!
      end
    end
  end
end
