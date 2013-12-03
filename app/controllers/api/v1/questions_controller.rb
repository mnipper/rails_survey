module Api
  module V1
    class QuestionsController < ApiApplicationController
      respond_to :json

      def index
        respond_with Question.all, include: :translations
      end

      def show
        respond_with Question.find(params[:id])
      end
    end
  end
end
