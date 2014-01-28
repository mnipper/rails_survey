class VersionsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @instrument = @project.instruments.find(params[:instrument_id])
  end

  def show
    @project = Project.find(params[:project_id])
    @instrument = @project.instruments.find(params[:instrument_id])
    @version = @instrument.versions[params[:id].to_i]
    if @version
      @instrument_version = @version.reify
    else
      redirect_to [@project, @instrument]
    end
  end
end
