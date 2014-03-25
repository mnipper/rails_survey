class ResponsesController < ApplicationController
  after_action :verify_authorized
  
  def index
    @instruments = current_project.instruments
    authorize @instruments
  end
  
end
