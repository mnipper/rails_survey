class StatsController < ApplicationController
  def index
    @instruments = Instrument.all
  end

  def show
    @instrument = Instrument.find(params[:id])
    select_one_ids = @instrument.questions.ids_for_single_and_multiple_select_questions('SELECT_ONE')
    @single_select_responses = Response.responses_by_question_ids(select_one_ids)
    select_multiple_ids = @instrument.questions.ids_for_single_and_multiple_select_questions('SELECT_MULTIPLE')
    @multiple_select_responses = Response.responses_by_question_ids(select_multiple_ids)

  end
end
