class DeviceUsersController < ApplicationController
  def index
    @device_users = current_project.device_users
    authorize @device_users
  end

  def show
    @device_user = current_project.device_users.find(params[:id])
    authorize @device_user
  end

  def new
    @device_user = current_project.device_users.new
    authorize @device_user
  end

  def edit
    @device_user = current_project.device_users.find(params[:id])
    authorize @device_user
  end

  def create
    @device_user = current_project.device_users.new(params[:device_user])
    authorize @device_user
    if @device_user.save
      redirect_to project_device_users_path(current_project), notice: 'Device User was successfully created.'
    else
      render :new
    end
  end

  def update
    @device_user = current_project.device_users.find(params[:id])
    authorize @device_user
    if @device_user.update(params[:device_user])
      redirect_to project_device_users_path(current_project), notice: 'Device User was successfully updated.'
    else
      render :edit
    end
  end
end
