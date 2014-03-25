class VersionsController < ApplicationController
  after_action :verify_authorized
  
  def index
    @instrument = current_project.instruments.find(params[:instrument_id])
    authorize @instrument
  end

  def show
    @instrument = current_project.instruments.find(params[:instrument_id])
    authorize @instrument
    @instrument_version = @instrument.version(params[:id])
  end
end
