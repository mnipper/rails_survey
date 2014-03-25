module Api
  module V1
    module Frontend
      class OptionsController < ApiApplicationController
        respond_to :json
        
        def index
            question = Question.find(params[:question_id])
            options = question.options
            authorize options
            respond_with options, include: :translations
        end

        def show
          option = Option.find(params[:id])
          authorize option
          respond_with option
        end

        def create
          @option = Option.new(params)
          authorize @option
          if @option.save
            render nothing: true, status: :created
          else
            render nothing: true, status: :unprocessable_entity
          end
        end

        def update
          option = Option.find(params[:id])
          authorize option
          respond_with option.update_attributes(params[:option])
        end

        def destroy
          option = Option.find(params[:id])
          authorize option
          respond_with option.destroy
        end
      end
    end
  end
end
