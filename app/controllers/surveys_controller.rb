class SurveysController < ApplicationController
  after_action :verify_authorized
  
  def index
    @surveys = current_project.surveys
    authorize @surveys
  end

  def show
    @survey = current_project.surveys.find(params[:id])
    authorize @survey
    @instrument_version = @survey.instrument_version
  end
end
