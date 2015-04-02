class GridsController < ApplicationController
  
  def index
    @project = current_project
    @instrument = @project.instruments.find(params[:instrument_id])
  end
  
end