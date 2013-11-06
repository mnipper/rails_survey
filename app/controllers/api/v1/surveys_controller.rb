module Api
  module V1
    class SurveysController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        @survey = Survey.new(survey_params.except(:device_identifier))
        @device = Device.find_by identifier: survey_params[:device_identifier]
        if @device
          @survey.device = @device
        else
          device = Device.create(identifier: survey_params[:device_identifier])
          @survey.device = device
        end
        respond_with @survey if @survey.save 
      end

      private
      def survey_params
        # TODO add fields to permit
        params.require(:survey).permit!
      end
    end
  end
end
