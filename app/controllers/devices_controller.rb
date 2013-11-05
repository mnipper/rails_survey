class DevicesController < ApplicationController
  def index
    @surveys = Survey.group(:device_identifier)
  end
end
