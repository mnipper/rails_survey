module Api
  module V1
    class ImagesController < ApiApplicationController
      respond_to :json
      
      def index
        respond_with Image.all.to_a
      end     
    end  
  end
end