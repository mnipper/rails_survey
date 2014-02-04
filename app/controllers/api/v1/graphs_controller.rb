module Api
  module V1
    class GraphsController < ApiApplicationController
      #protect_from_forgery with: :null_session
      respond_to :json
      
      def index
        puts "INDEX DAILY"
        respond_with current_project.daily_response_count 
      end
      
      def show
        puts "SHOW DAILY"
        respond_with current_project.daily_response_count
      end
      
    end
  end
end