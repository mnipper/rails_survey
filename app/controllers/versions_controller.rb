class VersionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @instrument = Instrument.find(params[:instrument_id])
  end

  def show
    @instrument = Instrument.find(params[:instrument_id])
    @version = @instrument.versions[params[:id].to_i]
    if @version
      @instrument_version = @version.reify
    else
      redirect_to @instrument, alert: 'This is not a valid instrument version.'
    end
  end
end
