class DevicesController < ApplicationController
  after_action :verify_authorized
  
  def index
    @devices = current_project.devices
    authorize @devices
  end
  
end
