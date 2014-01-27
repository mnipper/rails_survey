module Api
  module V1
    class QuestionsController < ApiApplicationController
      respond_to :json

      def index
        if params[:instrument_id]
          instrument = Instrument.find(params[:instrument_id])
          respond_with instrument.questions, include: :translations
        else
          respond_with Question.all, include: :translations
        end
      end

      def show
        respond_with Question.find(params[:id])
      end

      def create
        project = Project.find(params[:project_id])
        instrument = project.instruments.find(params[:instrument_id])
        question = instrument.questions.new(params[:question])
        if question.save
          render json: question, status: :created
        else
          render json: { errors: question.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        respond_with Question.find(params[:id]).update_attributes(params[:question])
      end

      def destroy
        respond_with Question.find(params[:id]).destroy
      end
    end
  end
end
