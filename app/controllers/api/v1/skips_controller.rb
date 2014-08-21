module Api
  module V1
    class SkipsController < ApiApplicationController
      respond_to :json
      def index
        project = Project.find(params[:project_id])
        respond_with project.skips.with_deleted
      end
      def show
        respond_with Skip.find(params[:id])
      end
    end 
  end
end