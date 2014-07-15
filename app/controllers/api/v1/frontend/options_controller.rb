module Api
  module V1
    module Frontend
      class OptionsController < ApiApplicationController
        respond_to :json
        
        def index
            question = current_project.questions.find(params[:question_id])
            options = question.options
            authorize options
            respond_with options, include: :translations
        end

        def show
          option = current_project.options.find(params[:id])
          authorize option
          respond_with option
        end

        def create
          question = current_project.questions.find(params[:question_id])
          @option = question.options.new(params)
          authorize @option
          if @option.save
            render nothing: true, status: :created
          else
            render nothing: true, status: :unprocessable_entity
          end
        end

        def update
          option = current_project.options.find(params[:id])
          authorize option
          respond_with option.update_attributes(params[:option])
        end

        def destroy
          option = current_project.options.find(params[:id])
          authorize option
          respond_with option.destroy
        end
      end
    end
  end
end
