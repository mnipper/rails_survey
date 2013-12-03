module Api
  module V1
    class QuestionsController < ApplicationController
      respond_to :json

      def index
        respond_with Question.all, include: :question_translations
      end

      def show
        respond_with Question.find(params[:id])
      end
    end
  end
end
