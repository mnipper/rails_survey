class OptionsController < ApplicationController
  
  private

  def option_params
    params.requre(:option).permit(:question_id, :text)
  end
end
