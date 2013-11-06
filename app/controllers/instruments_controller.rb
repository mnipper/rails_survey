class InstrumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @instruments = Instrument.all
  end

  def show
    @instrument = Instrument.find(params[:id])
  end

  def new
    @instrument = Instrument.new
  end

  def create
   @instrument = Instrument.new(instrument_params)
    if @instrument.save
      redirect_to @instrument, notice: "Successfully created instrument."
    else
      render :new
    end
  end

  def edit
    @instrument = Instrument.find(params[:id])
  end

  def update
    @instrument = Instrument.find(params[:id])
    if @instrument.update_attributes!(instrument_params)
      redirect_to @instrument, notice: "Successfully updated instrument."
    else
      render :edit
    end
  end

  def destroy
    @instrument = Instrument.find(params[:id])
    @instrument.destroy
    redirect_to instruments_url, notice: "Successfully destroyed instrument."
  end

  private

  def instrument_params
    # if current_user
    #params.require(:instrument).permit(:title, questions_attributes: [:text, :question_type,
    #    :question_identifier, :instrument_id, :_destroy, options_attributes: [:question_id, :text, :next_question]])
    # end
    params.require(:instrument).permit!
  end
end
