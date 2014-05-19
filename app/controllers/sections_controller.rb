class SectionsController < ApplicationController
  before_action :set_section, only: [:edit, :update, :destroy]

  def index
    @instrument = current_project.instruments.find(params[:instrument_id])
    @sections = @instrument.sections 
  end

  def new
    @instrument = current_project.instruments.find(params[:instrument_id])
    @section = @instrument.sections.new
  end

  def edit
  end

  def create
    @instrument = current_project.instruments.find(params[:instrument_id])
    @section = @instrument.sections.new(section_params)
    respond_to do |format|
      if @section.save
        format.html { redirect_to project_instrument_sections_path(current_project, @instrument), notice: 'Section was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    @instrument = current_project.instruments.find(params[:instrument_id])
    @section = @instrument.sections.find(params[:id])
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to project_instrument_sections_path(current_project, @instrument), notice: 'Section was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
     @instrument = current_project.instruments.find(params[:instrument_id])
    @section = @instrument.sections.find(params[:id])
    @section.destroy
    respond_to do |format|
      format.html { redirect_to project_instrument_sections_path(current_project, @instrument) }
    end
  end

  private
    def set_section
      @instrument = current_project.instruments.find(params[:instrument_id])
      @section = @instrument.sections.find(params[:id])
    end

    def section_params
      params[:section]
    end
end
