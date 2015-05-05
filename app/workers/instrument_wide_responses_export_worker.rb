class InstrumentWideResponsesExportWorker
  include Sidekiq::Worker

  def perform(instrument_id, csv_file, export_id)
    instrument = Instrument.find(instrument_id)
    instrument.surveys.to_csv(csv_file, export_id)
  end
  
end