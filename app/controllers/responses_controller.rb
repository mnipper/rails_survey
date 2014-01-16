class ResponsesController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @responses = @project.responses.all
    respond_to do |format|
      format.csv { render text: @responses.to_csv }
    end
  end
end
