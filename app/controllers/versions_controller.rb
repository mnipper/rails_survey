class VersionsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @instrument = Instrument.find(params[:instrument_id])
  end

  def show
    @instrument = Instrument.find(params[:instrument_id])
    @version = @instrument.versions[params[:id].to_i]
    if @version
      @instrument_version = @version.reify
    else
      redirect_to @instrument
    end
  end
end
