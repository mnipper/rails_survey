class ResponsesController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.csv { render text: @project.responses.to_csv }
    end
  end
end
