class InstrumentsController < ApplicationController
  after_action :verify_authorized
  
  def index
    @instruments = current_project.instruments
    authorize @instruments
  end

  def show
    @project = current_project
    @instrument = current_project.instruments.find(params[:id])
    authorize @instrument
  end

  def new
    @project = current_project
    @instrument = current_project.instruments.new
    authorize @instrument
  end

  def create
    @instrument = current_project.instruments.new(params[:instrument])
    authorize @instrument
    if @instrument.save
      redirect_to project_instrument_path(current_project, @instrument), notice: "Successfully created instrument."
    else
      render :new
    end
  end

  def edit
    @project = current_project
    @instrument = current_project.instruments.find(params[:id])
    authorize @instrument
  end

  def update
    @instrument = current_project.instruments.find(params[:id])
    authorize @instrument
    if @instrument.update_attributes(params[:instrument])
      redirect_to project_instrument_path(current_project, @instrument), notice: "Successfully updated instrument."
    else
      render :edit
    end
  end

  def destroy
    @instrument = current_project.instruments.find(params[:id])
    authorize @instrument
    @instrument.destroy
    redirect_to project_instruments_url, notice: "Successfully destroyed instrument."
  end

  def export
    @instrument = current_project.instruments.find(params[:id])
    authorize @instrument
    respond_to do |format|
      format.csv do 
        send_data @instrument.to_csv, 
          type: 'text/csv; charset=iso-8859-1; header=present',
          disposition: "attachment; filename=#{@instrument.title}_#{@instrument.current_version_number}.csv"
      end
    end
  end

  def export_responses
    @instrument = current_project.instruments.find(params[:id])
    authorize @instrument
    root = Rails.root.join('app', 'files', 'exports').to_s
    csv_file = File.new(root + "/#{Time.now.to_i}.csv", "a+")
    csv_file.close
    export = ResponseExport.create(:instrument_id => @instrument.id, :download_url => csv_file.path)
    if @instrument.response_images.empty?
      InstrumentResponsesExportWorker.perform_async(@instrument.id, csv_file.path, export.id, nil, nil)
    else
      zipped_file = File.new(root + "/#{Time.now.to_i}.zip", "a+")
      zipped_file.close 
      pictures_export = ResponseImagesExport.create(:response_export_id => export.id, :download_url => zipped_file.path)
      InstrumentResponsesExportWorker.perform_async(@instrument.id, csv_file.path, export.id, zipped_file.path, pictures_export.id)
    end
    redirect_to project_response_exports_path(current_project)
  end
  
end
