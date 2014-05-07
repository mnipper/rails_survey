module Api
  module V1
    module Frontend
      class GraphsController < ApiApplicationController
        protect_from_forgery with: :null_session
        respond_to :json
        
        def daily
          respond_with current_project.daily_response_count  
        end
        
        def hourly
          respond_with current_project.hourly_response_count 
        end
        
        def count
          hash = { 'count' => current_project.responses.count }
          respond_with [hash]
        end
      end  
    end
  end
end