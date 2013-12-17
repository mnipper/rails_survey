class InstrumentsController < ApplicationController
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
    @instrument = Instrument.new(params[:instrument])
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
    if @instrument.update_attributes(params[:instrument])
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
end
