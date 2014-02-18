class ResponsesController < ApplicationController
  def index
    respond_to do |format|
      format.csv { render text: current_project.responses.to_csv }
    end
  end
end
