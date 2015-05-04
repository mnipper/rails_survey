class DevicesController < ApplicationController
  after_action :verify_authorized
  
  def index
    @devices = current_project.devices.order('updated_at DESC')
    authorize @devices
  end
  
end
