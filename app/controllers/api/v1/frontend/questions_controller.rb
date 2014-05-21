module Api
  module V1
    module Frontend
      class QuestionsController < ApiApplicationController
        respond_to :json
        
        def index
          instrument = current_project.instruments.find(params[:instrument_id])
          if params[:page].blank?
            questions = instrument.questions
          else
            questions = instrument.questions.page(params[:page]).per(10)
          end
          authorize questions
          respond_with instrument, questions, include: :translations
        end

        def show
          question = Question.find(params[:id])
          authorize question
          respond_with question
        end

        def create
          instrument = current_project.instruments.find(params[:instrument_id])
          question = instrument.questions.new(params[:question])
          authorize question
          if question.save
            render json: question, status: :created
          else
            render json: { errors: question.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def update
          question = Question.find(params[:id])
          authorize question
          respond_with question.update_attributes(params[:question])
        end

        def destroy
          question = Question.find(params[:id])
          authorize question
          respond_with question.destroy
        end
      end
    end
  end
end
