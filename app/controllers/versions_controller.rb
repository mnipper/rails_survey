class VersionsController < ApplicationController
  after_action :verify_authorized
  
  def index
    @instrument = current_project.instruments.find(params[:instrument_id])
    authorize @instrument
  end

  def show
    @instrument = current_project.instruments.find(params[:instrument_id])
    authorize @instrument
    @instrument_version = @instrument.version_by_version_number(params[:id])
  end
end
