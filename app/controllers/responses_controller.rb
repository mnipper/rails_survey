class ResponsesController < ApplicationController
  def index
    @instruments = current_project.instruments
  end
end
