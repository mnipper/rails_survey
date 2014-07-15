module Api
  module V1
    module Frontend
      class ImagesController < ApiApplicationController
        skip_before_filter :authenticate_user!
        skip_before_filter :authenticate_user_from_token! #TODO FIX AUTHENTICATION WHEN USING ANGULAR FILE UPLOAD
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
          project = Project.find(params[:project_id])
          question = project.questions.find(params[:question_id])
          @image = question.images.new(:photo => params[:file], :question_id => params[:question_id])
          if @image.save
            render nothing: true, status: :created
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
