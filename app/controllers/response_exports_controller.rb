class ResponseExportsController < ApplicationController
  after_action :verify_authorized, :except => 
    [:index, :project_long_format_responses, :project_wide_format_responses, :instrument_long_format_responses,
      :instrument_wide_format_responses, :project_response_images, :instrument_response_images]
  
  def index
    @project_exports = current_project.response_exports.order('created_at DESC')
    @instrument_exports = current_project.instrument_response_exports
  end
  
  def new
    @project = current_project
    @export = current_project.response_exports.new
    authorize @export
  end
  
  def create
    @export = current_project.response_exports.new(params[:export])
    authorize @export
    if @export.save
      render text:"", notice: "Successfully created export."
    else
      render :new
    end
  end
  
  def edit
    @project = current_project
    @export = current_project.response_exports.find(params[:id])
    authorize @export
  end

  def update
    @export = current_project.response_exports.find(params[:id])
    authorize @export
    if @export.update_attributes(params[:export])
      render text:"", notice: "Successfully updated export."
    else
      render :edit
    end
  end
  
  def destroy
    @export = current_project.response_exports.find(params[:id])
    authorize @export
    @export.destroy
    render text:"", notice: "Successfully destroyed export."
  end
  
  def project_long_format_responses   
    export = current_project.response_exports.find params[:id]
    send_file export.long_format_url, :type => 'text/csv', :disposition => 'attachment', :filename => "#{ current_project.name.gsub(/\s+/,  '_') }.csv"
  end
  
  def project_wide_format_responses
    export = current_project.response_exports.find params[:id]
    send_file export.wide_format_url, :type => 'text/csv', :disposition => 'attachment', :filename => "#{ current_project.name.gsub(/\s+/,  '_') }.csv"
  end
  
  def instrument_long_format_responses
    export = ResponseExport.find(params[:id])
    instrument = current_project.instruments.find(export.instrument_id)
    if instrument
      instrument_download(export.long_format_url, 'text/csv', "#{ instrument.title.gsub(/\s+/,  '_') }.csv")
    end
  end
  
   def instrument_wide_format_responses
      export = ResponseExport.find(params[:id])
      instrument = current_project.instruments.find(export.instrument_id)
      if instrument
        instrument_download(export.wide_format_url, 'text/csv', "#{ instrument.title.gsub(/\s+/,  '_') }.csv")
      end
  end
  
  def project_response_images
    export = current_project.response_exports.find(params[:id])
    send_file export.response_images_export.download_url, :type => 'application/zip', :disposition => 'attachment', :filename => "#{ current_project.name.gsub(/\s+/,  '_') }.zip"
  end
  
  def instrument_response_images
    export = ResponseExport.find(params[:id])
    instrument_download(export.response_images_export.download_url, 'application/zip', "#{ current_project.instruments.find_by_id(export.instrument_id).title.gsub(/\s+/,  '_') }")
  end
  
  private

  def instrument_download(url, type, filename)
    send_file url, :type => type, :disposition => 'attachment', :filename => filename   
  end
  
end
