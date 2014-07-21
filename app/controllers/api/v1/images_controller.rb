module Api
  module V1
    class ImagesController < ApiApplicationController
      respond_to :json
      
      def index
        project = Project.find(params[:project_id])
        respond_with project.images
      end   
      
      def show
        @image = Image.find(params[:id])
        send_file @image.photo.path
      end
        
    end  
  end
end