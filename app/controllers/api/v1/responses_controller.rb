module Api
  module V1
    class ResponsesController < ApplicationController
      respond_to :json

      def create
        respond_with Response.create(params[:response])
      end
    end
  end
end
