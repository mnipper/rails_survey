class NotificationsController < ApplicationController
  def index
    @dangerous_devices = Device.all.select(&:danger_zone?) 
  end
end
