module Api
  module V1
    class AndroidUpdatesController < ApiApplicationController
      respond_to :json
      
      def index
        respond_with AndroidUpdate.latest_version
      end   
      
      def show
        @apk = AndroidUpdate.find(params[:id])
        send_file @apk.apk_update.path
      end
        
    end  
  end
end