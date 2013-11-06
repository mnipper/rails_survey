class DevicesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @devices = Device.all 
  end
end
