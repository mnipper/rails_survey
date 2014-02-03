module Api
  module V1
    class GraphsController < ApiApplicationController
      protect_from_forgery with: :null_session
      respond_to :json
      
      def daily_responses
        @responses = current_project.daily_response_count
        render json: @responses 
      end
      
    end
  end
end