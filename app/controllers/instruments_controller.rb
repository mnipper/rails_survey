class InstrumentsController < ApplicationController

  private

  def instrument_params
    params.require(:instrument).permit(:title, questions_attributes: [:text, :question_type,
        :question_identifier, :instrument_id])
  end
end
