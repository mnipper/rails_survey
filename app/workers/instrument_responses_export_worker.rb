class InstrumentResponsesExportWorker
  include Sidekiq::Worker

  def perform(instrument_id)
    inst = Instrument.find instrument_id
    export = ResponseExport.create(:instrument_id => instrument_id)
    csv_file = inst.responses.to_csv
    export.update(:download_url => csv_file.path, :done => true)
    unless inst.response_images.empty?
      pictures_export = ResponseImagesExport.create(:response_export_id => export.id)
      zip_file = inst.response_images.to_zip(inst.title)
      pictures_export.update(:download_url => zip_file.path, :done => true)
    end
  end
  
end