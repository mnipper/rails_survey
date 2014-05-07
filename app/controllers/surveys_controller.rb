class SurveysController < ApplicationController
  def index
    @surveys = current_project.surveys
  end

  def show
    @survey = current_project.surveys.find(params[:id])
    @instrument_version = @survey.instrument_version
  end
end
