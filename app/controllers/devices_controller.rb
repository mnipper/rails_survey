class DevicesController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @devices = @project.devices
  end
end
