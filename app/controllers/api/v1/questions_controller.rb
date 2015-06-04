module Api
  module V1
    class QuestionsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        instrument_ids_and_versions = {}
        if params[:device_instruments] && params[:device_instrument_versions]
          instrument_ids_and_versions = Hash[params[:device_instruments].split(",").map(&:to_i).zip params[:device_instrument_versions].split(",").map(&:to_i)]
        end
        questions = project.questions_to_sync(instrument_ids_and_versions, params[:deleted_questions]) 
        respond_with questions, include: :translations
      end

      def show
        respond_with Question.find(params[:id])
      end
    end
  end
end
