class QuestionsController < ApplicationController

  private

  def question_params
    params.require(:question).permit(:text, :question_type, :question_identifier, 
        :instrument_id, options_attributes: [:question_id, :text])
  end
end
