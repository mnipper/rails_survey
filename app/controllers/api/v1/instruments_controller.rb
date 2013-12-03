module Api
  module V1
    class InstrumentsController < ApiApplicationController
      respond_to :json

      def index
        respond_with Instrument.all, include: :translations
      end

      def show
        respond_with Instrument.find(params[:id])
      end
    end
  end
end
