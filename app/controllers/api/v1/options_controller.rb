module Api
  module V1
    class OptionsController < ApplicationController
      respond_to :json

      def index
        respond_with Option.all
      end

      def show
        respond_with Option.find(params[:id])
      end
    end
  end
end
