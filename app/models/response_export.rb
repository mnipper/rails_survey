class ResponseExport < ActiveRecord::Base
  attr_accessible :done, :download_url, :project_id, :instrument_id, :spss_syntax_file_url, :spss_friendly_csv_url, :value_labels_csv
  belongs_to :project
  belongs_to :instrument
  has_one :response_images_export
end
