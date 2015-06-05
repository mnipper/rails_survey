class InstrumentWideResponsesExportWorker
  include Sidekiq::Worker

  def perform(instrument_id, csv_file)
    instrument = Instrument.find(instrument_id)
    instrument.surveys.to_csv(csv_file)
  end
  
end