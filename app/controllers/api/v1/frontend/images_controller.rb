module Api
  module V1
    module Frontend
      class ImagesController < ApiApplicationController
        respond_to :json

        def index
          if current_user
            question = Question.find(params[:question_id])
            images = []
            question.images.each do |img|
              images << img.as_json
            end
            respond_with images       
          end
        end

        def show
          if current_user
            respond_with Image.find(params[:id])
          end
        end
        
        def create
          @image = Image.new(:photo => params[:file], :question_id => params[:question_id])
          if @image.save
            render nothing: true, status: :created
          else
            render nothing: true, status: :unprocessable_entity
          end
        end
        
        def destroy
          respond_with Image.find(params[:id]).destroy
        end
        
      end
    end
  end
end