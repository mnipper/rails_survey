class ResponseImagesController < ApplicationController
  
  def show
    @image = current_project.response_images.find(params[:id])
  end
  
end
