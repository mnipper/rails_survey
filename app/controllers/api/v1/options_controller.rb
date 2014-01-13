module Api
  module V1
    class OptionsController < ApiApplicationController
      respond_to :json

      def index
        if params[:question_id]
          question = Question.find(params[:question_id])
          respond_with question.options, include: :translations
        else
          respond_with Option.all, include: :translations
        end
      end

      def show
        respond_with Option.find(params[:id])
      end

      def create
        respond_with Option.create(params)
      end

      def update
        respond_with Option.find(params[:id]).update_attributes(params[:option])
      end

      def destroy
        respond_with Option.find(params[:id]).destroy
      end
    end
  end
end
