class InstrumentResponsesExportWorker
  include Sidekiq::Worker

  def perform(instrument_id, csv_file, export_id, zipped_file, pictures_export_id)
    inst = Instrument.find(instrument_id)
    inst.responses.to_csv(csv_file, export_id)
    unless inst.response_images.empty?
      inst.response_images.to_zip(inst.title, zipped_file, pictures_export_id)
    end
  end
  
end