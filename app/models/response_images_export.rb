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
  before_destroy :destroy_files

  private
  def destroy_files
    if download_url
      File.delete(download_url) if File.exist?(download_url)
    end
  end
  
end
