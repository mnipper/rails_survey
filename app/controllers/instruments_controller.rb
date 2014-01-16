class InstrumentsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @instruments = Instrument.where(:project_id => params[:project_id])
  end

  def show
    @instrument = Instrument.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  def new
    @project = Project.find(params[:project_id])
    @instrument = Instrument.new
  end

  def create
    @instrument = Instrument.new(params[:instrument])
    if @instrument.save
      redirect_to project_instrument_path(:project_id => params[:project_id], :id => @instrument), notice: "Successfully created instrument."
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @instrument = Instrument.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @instrument = Instrument.find(params[:id])
    if @instrument.update_attributes(params[:instrument])
      redirect_to project_instrument_path(@project, @instrument), notice: "Successfully updated instrument."
    else
      render :edit
    end
  end

  def destroy
    @instrument = Instrument.find(params[:id])
    @instrument.destroy
    redirect_to project_instruments_url, notice: "Successfully destroyed instrument."
  end
end
