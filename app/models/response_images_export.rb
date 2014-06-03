# == Schema Information
#
# Table name: response_images_exports
#
#  id                 :integer          not null, primary key
#  response_export_id :integer
#  download_url       :string(255)
#  done               :boolean          default(FALSE)
#  created_at         :datetime
#  updated_at         :datetime
#

class ResponseImagesExport < ActiveRecord::Base
  attr_accessible :download_url, :done, :response_export_id 
  belongs_to :response_export 
end
