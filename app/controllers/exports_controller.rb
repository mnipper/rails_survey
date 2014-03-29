class ExportsController < ApplicationController
  #TODO authorize 
  
  def index
    @project_exports = current_project.exports.order('created_at DESC')
    @instrument_exports = current_project.instrument_exports.sort_by!(&:created_at) #TODO fix sort order
  end
  
  def new
    @project = current_project
    @export = current_project.exports.new
  end
  
  def create
    @export = current_project.exports.new(params[:export])
    if @export.save
      render text:"", notice: "Successfully created export."
    else
      render :new
    end
  end
  
  def edit
    @project = current_project
    @export = current_project.exports.find(params[:id])
  end

  def update
    @export = current_project.exports.find(params[:id])
    if @export.update_attributes(params[:export])
      render text:"", notice: "Successfully updated export."
    else
      render :edit
    end
  end
  
  def destroy
    @export = current_project.exports.find(params[:id])
    @export.destroy
    render text:"", notice: "Successfully destroyed export."
  end
  
  def download_project_responses 
    export = Export.find params[:id]
    send_file export.download_url, :type => 'text/csv', :disposition => 'attachment', :filename => "#{current_project.name}" 
  end
  
  def download_instrument_responses
    export = Export.find params[:id]
    instrument = Instrument.find(export.instrument_id)
    send_file export.download_url, :type => 'text/csv', :disposition => 'attachment', :filename => "#{instrument.title}"
  end
  
end
