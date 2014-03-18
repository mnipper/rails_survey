module Api
  module V1
    class QuestionsController < ApiApplicationController
      respond_to :json

      def index
        project = Project.find(params[:project_id])
        respond_with project.questions, include: :translations
      end

      def show
        respond_with Question.find(params[:id])
      end
    end
  end
end
