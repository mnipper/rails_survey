module Api
  module V1
    class DeviceSyncEntriesController < ApiApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        device = Device.find_by_identifier(params[:device_sync_entry][:device_uuid])
        project = Project.find_by_id(params[:device_sync_entry][:project_id])
        if device
          device.projects << project if project && !device.projects.include?(project)
        else
          device = Device.new
          device.projects << project if project && !device.projects.include?(project)
          device.identifier = params[:device_sync_entry][:device_uuid]
          device.label = params[:device_sync_entry][:device_label]
          device.save
        end
        params[:device_sync_entry].delete :project_id
        params[:device_sync_entry].delete :device_label
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
