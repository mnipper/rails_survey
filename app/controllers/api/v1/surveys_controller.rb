module Api
  module V1
    class SurveysController < ApiApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        @survey = Survey.new(params.except(:device_identifier))
        @device = Device.find_by identifier: params[:device_identifier]
        if @device
          @survey.device = @device
        else
          device = Device.new
          device.identifier = params[:device_identifier]
          device.save
          @survey.device = device
        end
        respond_with @survey if @survey.save 
      end
    end
  end
end
