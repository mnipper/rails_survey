module Api
  module V1
    class OptionsController < ApiApplicationController
      respond_to :json

      def index
        respond_with Option.all, include: :translations
      end

      def show
        respond_with Option.find(params[:id])
      end
    end
  end
end
