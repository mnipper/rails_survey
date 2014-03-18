module Api
  module V1
    class OptionsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        respond_with project.options, include: :translations
      end

      def show
        respond_with Option.find(params[:id])
      end
    end
  end
end
