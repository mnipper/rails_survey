module Api
  module V1
    class SurveysController < ApiApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        @survey = Survey.new(params[:survey].except(:device_identifier))
        @device = Device.find_by identifier: params[:survey][:device_identifier]
        if @device
          @survey.device = @device
        else
          device = Device.new
          device.identifier = params[:survey][:device_identifier]
          device.save
          @survey.device = device
        end

        if @survey.save
          render json: @survey, status: :created
        else
          render nothing: true, status: :unprocessable_entity
        end
      end
    end
  end
end
