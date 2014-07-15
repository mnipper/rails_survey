module Api
  module V1
    module Frontend
      class ImagesController < ApiApplicationController
        respond_to :json

        def index
          question = Question.find(params[:question_id])
          respond_with question.images       
        end

        def show
          @image = Image.find(params[:id])
          send_file @image.photo.path(:medium), :type => @image.photo_content_type, :disposition => 'inline'
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