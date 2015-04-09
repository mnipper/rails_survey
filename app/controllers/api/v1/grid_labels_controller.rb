module Api
  module V1
    class GridLabelsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        respond_with project.grid_labels
      end
      
    end 
  end
end