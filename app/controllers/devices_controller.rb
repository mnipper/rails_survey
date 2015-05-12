class DevicesController < ApplicationController
  
  def index
    with_sync_entries = current_project.devices.group(:identifier).joins(:device_sync_entries).order('device_sync_entries.updated_at DESC')
    without_sync_entries = current_project.devices.includes(:device_sync_entries).where('device_sync_entries.id is null') 
    @devices = with_sync_entries + without_sync_entries
  end
  
end
