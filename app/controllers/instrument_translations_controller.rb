class InstrumentTranslationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @instrument = Instrument.find(params[:instrument_id])
    @instrument_translations = @instrument.instrument_translations.all
  end

  def show
    @instrument = Instrument.find(params[:instrument_id])
    @instrument_translation = @instrument.instrument_translations.find(params[:id])
  end

  def new
    @instrument = Instrument.find(params[:instrument_id])
    @instrument_translation = InstrumentTranslation.new
  end

  def create
   @instrument_translation = InstrumentTranslation.new(params[:instrument_translation])
    if @instrument_translation.save
      redirect_to @instrument_translation, notice: "Successfully created instrument translation."
    else
      render :new
    end
  end

  def edit
    @instrument = Instrument.find(params[:instrument_id])
    @instrument_translation = @instrument.instrument_translations.find(params[:id])
  end

  def update
    @instrument_translation = InstrumentTranslation.find(params[:id])
    if @instrument_translation.update_attributes!(params[:instrument_translation])
      redirect_to @instrument_translation, notice: "Successfully updated instrument translation."
    else
      render :edit
    end
  end

  def destroy
    @instrument_translation = InstrumentTranslation.find(params[:id])
    @instrument_translation.destroy
    redirect_to instrument_translations_url, notice: "Successfully destroyed instrument translation."
  end
end
