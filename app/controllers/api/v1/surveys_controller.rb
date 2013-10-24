module Api
  module V1
    class SurveysController < ApplicationController
      respond_to :json

      def create
        respond_with Survey.create(params[:survey])
      end
    end
  end
end
