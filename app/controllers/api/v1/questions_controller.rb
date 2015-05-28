module Api
  module V1
    class QuestionsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        instruments = project.instruments_to_sync(params[:instrument_versions])
        questions = project.questions_to_sync(instruments.map { |instrument| instrument.id }) if instruments
        respond_with questions, include: :translations
      end

      def show
        respond_with Question.find(params[:id])
      end
    end
  end
end
