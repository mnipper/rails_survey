module Api
  module V1
    class RulesController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        respond_with project.rules.with_deleted
      end
    end 
  end
end
