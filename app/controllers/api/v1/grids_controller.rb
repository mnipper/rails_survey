module Api
  module V1
    class GridsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        respond_with project.grids
      end
      
    end 
  end
end