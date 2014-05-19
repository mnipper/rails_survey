class InstrumentResponsesExportWorker
  include Sidekiq::Worker

  def perform(instrument_id)
    inst = Instrument.find instrument_id
    export = ResponseExport.create(:instrument_id => instrument_id)
    csv_file = inst.responses.to_csv
    spss_csv_file = inst.responses.to_spss_friendly_csv
    spss_file = inst.responses.spss_label_values
    value_labels_csv = inst.responses.value_labels_csv
    export.update(:download_url => csv_file.path, :done => true)
    export.update(:spss_friendly_csv_url => spss_csv_file.path)
    export.update(:spss_syntax_file_url => spss_file.path)
    export.update(:value_labels_csv => value_labels_csv.path)
    unless inst.response_images.empty?
      pictures_export = ResponseImagesExport.create(:response_export_id => export.id)
      zip_file = inst.response_images.to_zip(inst.title)
      pictures_export.update(:download_url => zip_file.path, :done => true)
    end
  end
  
end