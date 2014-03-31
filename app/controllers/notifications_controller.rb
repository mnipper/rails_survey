class NotificationsController < ApplicationController
  after_action :verify_authorized
  
  def index
    @dangerous_devices = current_project.non_responsive_devices
    authorize @dangerous_devices
  end
  
end
