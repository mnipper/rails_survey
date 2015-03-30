# == Schema Information
#
# Table name: response_exports
#
#  id                    :integer          not null, primary key
#  download_url          :string(255)
#  done                  :boolean          default(FALSE)
#  created_at            :datetime
#  updated_at            :datetime
#  project_id            :integer
#  instrument_id         :integer
#  spss_syntax_file_url  :string(255)
#  spss_friendly_csv_url :string(255)
#  value_labels_csv      :string(255)
#  instrument_versions   :text
#

class ResponseExport < ActiveRecord::Base
  attr_accessible :done, :download_url, :project_id, :instrument_id, :instrument_versions, :spss_syntax_file_url, :spss_friendly_csv_url, :value_labels_csv
  serialize :instrument_versions
  belongs_to :project
  belongs_to :instrument
  has_one :response_images_export, dependent: :destroy  
  before_destroy :destroy_files
  
  private
  def destroy_files
    if download_url
      File.delete(download_url) if File.exist?(download_url)
    end
    if spss_syntax_file_url
      File.delete(spss_syntax_file_url) if File.exist?(spss_syntax_file_url)
    end
    if spss_friendly_csv_url
      File.delete(spss_friendly_csv_url) if File.exist?(spss_friendly_csv_url)
    end
    if value_labels_csv
      File.delete(value_labels_csv) if File.exist?(value_labels_csv)
    end
  end
end
