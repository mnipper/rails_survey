module Api
  module V1
    class InstrumentsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        instrument_ids_and_versions = {}
        if params[:device_instruments] && params[:device_instrument_versions]
          instrument_ids_and_versions = Hash[params[:device_instruments].split(",").map(&:to_i).zip params[:device_instrument_versions].split(",").map(&:to_i)]
        end
        instruments = project.instruments_to_sync(instrument_ids_and_versions, params[:deleted_instruments])
        respond_with instruments, include: :translations
      end

      def show
        project = Project.find(params[:project_id])
        respond_with project.instruments.find(params[:id])
      end
    end
  end
end
