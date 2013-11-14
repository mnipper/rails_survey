class StatsController < ApplicationController
  def index
    @instruments = Instrument.all
  end

  def show
    @instrument = Instrument.find(params[:id])
    @question_ids = @instrument.questions.ids_for_select_one_questions
    @responses = Response.responses_by_question_ids(@question_ids)

  end
end
