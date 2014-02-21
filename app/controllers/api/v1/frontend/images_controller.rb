module Api
  module V1
    module Frontend
      class ImagesController < ApiApplicationController
        respond_to :json

        def index
          if current_user
            question = Question.find(params[:question_id])
            respond_with question.images         
          end
        end

        def show
          if current_user
            respond_with Image.find(params[:id])
          end
        end
        
        def create
          @image = Image.new(params)
          if @image.save
            render nothing: true, status: :created
          else
            render nothing: true, status: :unprocessable_entity
          end
        end
        
      end
    end
  end
end