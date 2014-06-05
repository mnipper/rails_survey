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
          instrument.reorder_questions(old_number, question.number_in_instrument) if old_number != question.number_in_instrument
          respond_with question 
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
