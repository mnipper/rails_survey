module Api
  module V1
    class OptionsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        instruments = project.instruments_to_sync(params[:instrument_versions])
        options = project.options_to_sync(instruments) if instruments
        respond_with options, include: :translations
      end

      def show
        respond_with Option.find(params[:id])
      end
    end
  end
end
