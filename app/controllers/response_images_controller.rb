class ResponseImagesController < ApplicationController
  after_action :verify_authorized
  
  def show
    @image = current_project.response_images.find(params[:id])
    authorize @image
  end
  
end
