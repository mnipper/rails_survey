module Api
  module V1
    class DeviceSyncEntriesController < ApiApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        @device_sync_entry = DeviceSyncEntry.new(params[:device_sync_entry])
        if @device_sync_entry.save
          render json: @device_sync_entry, status: :created
        else
          render nothing: true, status: :unprocessable_entity
        end
      end
    end
  end
end
