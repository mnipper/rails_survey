class InstrumentsController < ApplicationController

  private

  def instrument_params
    params.require(:instrument).permit(:title)
  end
end
