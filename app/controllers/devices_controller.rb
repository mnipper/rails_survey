class DevicesController < ApplicationController
  
  def index
    with_sync_entries = current_project.devices.select('devices.*, MAX(device_sync_entries.updated_at) AS most_recent')
      .joins(:device_sync_entries).order('most_recent DESC').group('devices.id')
    without_sync_entries = current_project.devices.includes(:device_sync_entries).where('device_sync_entries.id is null') 
    @devices = with_sync_entries + without_sync_entries
  end
  
end
