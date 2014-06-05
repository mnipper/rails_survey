module Api
  module V1
    module Frontend
      class QuestionsController < ApiApplicationController
        respond_to :json
        
        def index
          instrument = current_project.instruments.find(params[:instrument_id])
          if params[:page].blank?
            respond_with [instrument]
          else
            questions = instrument.questions.page(params[:page]).per(Settings.questions_per_page)
            authorize questions
            respond_with questions, include: :translations
          end 
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
            ReorderQuestionsWorker.perform_async(instrument.id, instrument.questions.last.number_in_instrument, question.number_in_instrument)
            render json: question, status: :created
          else
            render json: { errors: question.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def update
          instrument = current_project.instruments.find(params[:instrument_id])
          question = instrument.questions.find(params[:id])
          authorize question
          old_number = question.number_in_instrument
          question.update_attributes(params[:question])
          if old_number != question.number_in_instrument
            ReorderQuestionsWorker.perform_async(instrument.id, old_number, question.number_in_instrument)
          end
          respond_with question 
        end

        def destroy
          instrument = current_project.instruments.find(params[:instrument_id])
          question = instrument.questions.find(params[:id])
          authorize question
          question_number = question.number_in_instrument
          if question.destroy
            DeleteQuestionWorker.perform_async(instrument.id, question_number)
            render nothing: true, status: :ok
          else
            render json: { errors: question.errors.full_messages }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
