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
#

class ResponseExport < ActiveRecord::Base
  attr_accessible :done, :download_url, :project_id, :instrument_id, :spss_syntax_file_url, :spss_friendly_csv_url, :value_labels_csv
  belongs_to :project
  belongs_to :instrument
  has_one :response_images_export
end
