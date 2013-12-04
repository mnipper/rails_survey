module Api
  module V1
    class ResponsesController < ApiApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        @response = Response.new(params[:response])
        if @response.save
          respond_with @response
        else
          render nothing: true, status: :unprocessable_entity
        end
      end
    end
  end
end
