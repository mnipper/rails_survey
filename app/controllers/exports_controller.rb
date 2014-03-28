class ExportsController < ApplicationController
  #TODO authorize 
  def index
    @exports = current_project.exports 
  end
  
end
