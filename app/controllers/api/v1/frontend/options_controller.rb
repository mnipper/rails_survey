module Api
  module V1
    module Frontend
      class OptionsController < ApiApplicationController
        respond_to :json

        def index
            question = Question.find(params[:question_id])
            respond_with question.options, include: :translations
        end

        def show
          respond_with Option.find(params[:id])
        end

        def create
          @option = Option.new(params)
          if @option.save
            render nothing: true, status: :created
          else
            render nothing: true, status: :unprocessable_entity
          end
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
end
