class ResponseImagesController < ApplicationController
  after_action :verify_authorized
  
  def show
    @image = current_project.response_images.find(params[:id])
    authorize @image
    send_file @image.picture.path(:medium), :type => @image.picture_content_type, :disposition => 'inline'
  end
  
end
