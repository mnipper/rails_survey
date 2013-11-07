class GraphsController < ApplicationController

  def real_time
    @count = Response.count
    @count_html = render_to_string(partial: 'graphs/partials/realtime').html_safe
    respond_to_ajax
  end

  def bars
    @counts = Instrument.instrument_response_count
    @counts_html = render_to_string(partial: 'graphs/partials/bars').html_safe
    respond_to_ajax
  end

  def update
    @num_surveys = Response.count
    @num_surveys_html = render_to_string(partial: 'graphs/partials/update').html_safe
    respond_to_ajax
  end

  def hourly
    @responses = Response.responses_by_hour
  end
end
