class RulesController < ApplicationController
  def index
    @rules = current_project.rules
    authorize @rules
  end

  def show
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
  end
end
