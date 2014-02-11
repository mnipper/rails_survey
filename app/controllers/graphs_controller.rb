class GraphsController < ApplicationController

  def real_time
    @count = Instrument.instrument_response_count
    @count_html = render_to_string(partial: 'graphs/partials/realtime').html_safe
    @responses = Response.responses_by_hour
    respond_to_ajax
  end

  def bars
    @counts = Instrument.instrument_response_count

    summary_stats = []
    @counts.each do |instrument|
      summary_stats << instrument.values
    end
    @summary_statistics = simple_descriptive_statistics(summary_stats.flatten)

    @responses = {}
    instruments = Instrument.all
    instruments.each do |instrument|
       @responses[instrument.title] = instrument.response_count_per_day
    end

    @instrument_summary = {}
    @responses.each do |name, sum_values|
       @instrument_summary[name] = simple_descriptive_statistics(sum_values.values)
    end

    @counts_html = render_to_string(partial: 'graphs/partials/bars_ajax').html_safe
    @responses_html = render_to_string(partial: 'graphs/partials/daily_ajax').html_safe
    respond_to_ajax
  end

  def daily_responses
    #@responses = {}
    #instruments = Instrument.all
    #instruments.each do |instrument|
     # @responses[instrument.title] = instrument.response_count_per_day
    #end
    #@responses_html = render_to_string(partial: 'graphs/partials/daily_ajax').html_safe
    #respond_to_ajax
    #@project = current_project 
    @responses = current_project.daily_response_count 
  end

  def update
    @num_surveys = Response.count
    @num_surveys_html = render_to_string(partial: 'graphs/partials/update').html_safe
    respond_to_ajax
  end

  def hourly_responses
    #@responses = Response.responses_by_hour
    @responses = current_project.hourly_response_count
    puts @responses 
  end
end
