module Api
  module V1
    class SectionsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        respond_with project.sections.with_deleted, include: :translations
      end

      def show
        project = Project.find(params[:project_id])
        respond_with project.sections.find(params[:id])
      end
    end
  end
end
