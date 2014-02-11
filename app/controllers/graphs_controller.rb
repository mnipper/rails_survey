class GraphsController < ApplicationController

  def daily_responses 
    current_project.daily_response_count 
  end

  def hourly_responses
    current_project.hourly_response_count
  end
end
