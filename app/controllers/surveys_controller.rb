class SurveysController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @surveys = @project.surveys
  end

  def show
    @survey = Survey.find(params[:id])
    @instrument_version = @survey.instrument_version
  end
end
