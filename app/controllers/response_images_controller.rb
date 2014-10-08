class ResponseImagesController < ApplicationController
  after_action :verify_authorized
  
  def show
    @image = current_project.response_images.find(params[:id])
    authorize @image
    if @image.picture.path
      send_file @image.picture.path(:medium), :type => @image.picture_content_type, :disposition => 'inline'
    else
      send_file @image.picture.url(:medium), :type => 'image/png', :disposition => 'inline'
    end
  end
  
end
