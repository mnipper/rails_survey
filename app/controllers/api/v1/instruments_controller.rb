module Api
  module V1
    class InstrumentsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        if current_user
          respond_with project.instruments, include: [:translations, :device_notifications]
        else
          respond_with project.instruments.published, include: [:translations, :device_notifications]
        end
      end

      def show
        project = Project.find(params[:project_id])
        if current_user
          respond_with project.instruments, include: [:translations, :device_notifications]
        else
          respond_with project.instruments.published.find(params[:id])
        end
      end
    end
  end
end
