module Api
  module V1
    module Frontend
      class ImagesController < ApiApplicationController
        respond_to :json

        def index
          question = current_project.questions.find(params[:question_id])
          respond_with question.images       
        end

        def show
          @image = current_project.images.find(params[:id])
          send_file @image.photo.path(:medium), :type => @image.photo_content_type, :disposition => 'inline'
        end
        
        def create
          question = current_project.questions.find(params[:question_id])
          @image = question.images.new(:photo => params[:file], :question_id => params[:question_id])
          if @image.save
            render nothing: true, status: :created
          else
            render nothing: true, status: :unprocessable_entity
          end 
        end
        
        def update
          question = current_project.questions.find(params[:question_id])
          image = question.images.find(params[:id])
          if image.update_attributes(params[:image])
            respond_with image
          else
            render nothing: true, status: :unprocessable_entity
          end
        end
        
        def destroy
          respond_with current_project.images.find(params[:id]).destroy
        end
        
      end
    end
  end
end
