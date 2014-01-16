class DevicesController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @devices = Device.all # TODO Fix
  end
end
