module Api
  module V1
    class RulesController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        respond_with project.rules
      end
    end 
  end
end
