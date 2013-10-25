module Api
  module V1
    class SurveysController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        respond_with Survey.create(survey_params)
      end

      private
      def survey_params
        # TODO add fields to permit
        params.require(:survey).permit!
      end
    end
  end
end
