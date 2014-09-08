class RulesController < ApplicationController
  def index
    @rules = current_project.rules
    authorize @rules
  end

  def show
  end

  def edit
    @rule = current_project.rules.find(params[:id])
    authorize @rule
  end

  def update
    @rule = current_project.rules.find(params[:id])
    authorize @rule
    if @rule.update(params[:rule])
      redirect_to project_rules_path(current_project), notice: 'Rule was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @rule = current_project.rules.new
    authorize @rule
  end

  def create
    @rule = current_project.rules.new(params[:rule])
    authorize @rule
    if @rule.save
      redirect_to project_rules_path(current_project), notice: 'Rule was successfully created.'
    else
      render :new
    end
  end
  
  def destroy
    @rule = current_project.rules.find(params[:id])
    authorize @rule
    @rule.destroy
    redirect_to project_rules_url(current_project)
  end
end
