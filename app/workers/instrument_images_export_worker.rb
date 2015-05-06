class InstrumentImagesExportWorker
  include Sidekiq::Worker

  def perform(instrument_id, zipped_file, pictures_export_id)
    instrument = Instrument.find(instrument_id)
    unless instrument.response_images.empty?
      instrument.response_images.to_zip(instrument.title, zipped_file, pictures_export_id)
    end
  end
  
end