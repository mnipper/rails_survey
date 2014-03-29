class InstrumentExportsWorker
  include Sidekiq::Worker

  def perform(instrument_id)
    inst = Instrument.find instrument_id
    export = Export.create(:instrument_id => instrument_id)
    csv_file = inst.responses.to_csv
    export.update(:download_url => csv_file.path, :done => true)
  end
  
end