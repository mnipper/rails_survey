class InstrumentLongResponsesExportWorker
  include Sidekiq::Worker

  def perform(instrument_id, csv_file, export_id)
    inst = Instrument.find(instrument_id)
    inst.responses.to_csv(csv_file, export_id)
  end
  
end