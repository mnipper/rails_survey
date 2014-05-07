class NotificationsController < ApplicationController
  def index
    @dangerous_devices = current_project.devices.select(&:danger_zone?) 
  end
end
