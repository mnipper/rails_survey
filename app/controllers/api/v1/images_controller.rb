module Api
  module V1
    class ImagesController < ApiApplicationController
      respond_to :json
      
      def index
        project = Project.find(params[:project_id])
        respond_with project.images
      end     
    end  
  end
end