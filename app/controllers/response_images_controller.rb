class ResponseImagesController < ApplicationController
  
  def show
    @image = ResponseImage.find(params[:id])
  end
  
end
