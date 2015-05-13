class DevicesController < ApplicationController
  
  def index
    @devices = current_project.devices.sort.reverse
  end
  
end
