class ResponseImagesExport < ActiveRecord::Base
  attr_accessible :download_url, :done, :response_export_id 
  belongs_to :response_export 
end
