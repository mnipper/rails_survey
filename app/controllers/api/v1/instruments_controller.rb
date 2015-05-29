module Api
  module V1
    class InstrumentsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        instruments = project.instruments_to_sync(params[:instrument_versions], params[:deleted_instruments])
        respond_with instruments, include: :translations
      end

      def show
        project = Project.find(params[:project_id])
        respond_with project.instruments.find(params[:id])
      end
    end
  end
end
