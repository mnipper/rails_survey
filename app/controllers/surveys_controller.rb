class SurveysController < ApplicationController
  def index
    @surveys = current_project.surveys
  end

  def show
    @survey = current_project.surveys.find(params[:id])
    @instrument_version = @survey.instrument_version
  end

  def export
    @survey = current_project.surveys.find(params[:id])
    respond_to do |format|
      format.csv { render text: @survey.responses.to_csv }
    end
  end
end
