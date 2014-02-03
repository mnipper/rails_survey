class DeviceNotificationsController < ApplicationController
  def index
    @instrument = current_project.instruments.find(params[:instrument_id])
    @device_notifications = @instrument.device_notifications
  end

  def new
    @instrument = current_project.instruments.find(params[:instrument_id])
    @device_notification = @instrument.device_notifications.new
  end

  def create
    @instrument = current_project.instruments.find(params[:instrument_id])
    @device_notification = @instrument.device_notifications.new(params[:device_notification])
    if @device_notification.save
      redirect_to project_instrument_path(current_project, @instrument),
        notice: "Successfully created device notification."
    else
      render :new
    end
  end

  def edit
    @instrument = current_project.instruments.find(params[:instrument_id])
    @device_notification = @instrument.device_notifications.find(params[:id])
  end

  def update
    @instrument = current_project.instruments.find(params[:instrument_id])
    @device_notification = @instrument.device_notifications.find(params[:id])
    if @device_notification.update_attributes(params[:device_notification])
      redirect_to project_instrument_path(current_project, @instrument),
        notice: "Successfully updated device notification."
    else
      render :edit
    end
  end
end
