module Api
  module V1
    class InstrumentsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        respond_with project.instruments, include: :translations
      end

      def show
        project = Project.find(params[:project_id])
        respond_with project.instruments.find(params[:id])
      end
    end
  end
end
