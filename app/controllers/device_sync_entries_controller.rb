class DeviceSyncEntriesController < ApplicationController
  after_action :verify_authorized

  def index
    @device = current_project.devices.find(params[:device_id])
    @device_sync_entries = @device.device_sync_entries
    authorize @device_sync_entries
  end
end
