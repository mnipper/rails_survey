class GraphsController < ApplicationController

  def realtime
     @count = Response.count
  end

  def bars
    @counts = Instrument.instrument_response_count
  end

  def update
    @num_surveys = Response.count
    @num_surveys_html = render_to_string(partial: 'graphs/partials/update').html_safe
    respond_to_ajax
  end

  def show

  end
end
