# == Schema Information
#
# Table name: response_exports
#
#  id                  :integer          not null, primary key
#  long_format_url     :string(255)
#  long_done           :boolean          default(FALSE)
#  created_at          :datetime
#  updated_at          :datetime
#  project_id          :integer
#  instrument_id       :integer
#  instrument_versions :text
#  wide_format_url     :string(255)
#  wide_done           :boolean          default(FALSE)
#

class ResponseExport < ActiveRecord::Base
  attr_accessible :long_format_url, :wide_format_url, :project_id, :instrument_id, :instrument_versions, :long_done, :wide_done
  serialize :instrument_versions
  belongs_to :project
  belongs_to :instrument
  has_one :response_images_export, dependent: :destroy  
  before_destroy :destroy_files
  
  private
  def destroy_files
    if long_format_url
      File.delete(long_format_url) if File.exist?(long_format_url)
    end
    if wide_format_url
      File.delete(wide_format_url) if File.exist?(wide_format_url)
    end    
  end
  
end
