class VersionsController < ApplicationController
  def index
    @instrument = current_project.instruments.find(params[:instrument_id])
  end

  def show
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_version = @instrument.version(params[:id])
  end
end
