class NotificationsController < ApplicationController
  #after_action :verify_authorized
  
  def index
    @dangerous_devices = current_project.devices.select(&:danger_zone?) 
    #authorize @dangerous_devices
  end
  
end
