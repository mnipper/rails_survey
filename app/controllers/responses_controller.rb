class ResponsesController < ApplicationController
  def index
    @responses = Response.all
    respond_to do |format|
      format.csv { render text: @responses.to_csv }
    end
  end
end
