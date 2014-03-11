class DevicesController < ApplicationController
  def index
    @devices = current_project.devices.to_a 
  end
end
