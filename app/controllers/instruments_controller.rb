class InstrumentsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @instruments = @project.instruments
  end

  def show
    @project = Project.find(params[:project_id])
    @instrument = @project.instruments.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @instrument = @project.instruments.new
  end

  def create
    @project = Project.find(params[:project_id])
    @instrument = @project.instruments.new(params[:instrument])
    if @instrument.save
      redirect_to project_instrument_path(@project, @instrument), notice: "Successfully created instrument."
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @instrument = @project.instruments.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @instrument = @project.instruments.find(params[:id])
    if @instrument.update_attributes(params[:instrument])
      redirect_to project_instrument_path(@project, @instrument), notice: "Successfully updated instrument."
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @instrument = @project.instruments.find(params[:id])
    @instrument.destroy
    redirect_to project_instruments_url, notice: "Successfully destroyed instrument."
  end

  def export
    @instrument = current_project.instruments.find(params[:id])
    respond_to do |format|
      format.csv do 
        send_data @instrument.to_csv, 
          type: 'text/csv; charset=iso-8859-1; header=present',
          disposition: "attachment; filename=#{@instrument.title}_#{@instrument.current_version_number}.csv"
      end
    end
  end
end
