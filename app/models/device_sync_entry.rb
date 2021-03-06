# == Schema Information
#
# Table name: device_sync_entries
#
#  id                   :integer          not null, primary key
#  latitude             :string(255)
#  longitude            :string(255)
#  num_surveys          :integer
#  current_language     :string(255)
#  current_version_code :string(255)
#  instrument_versions  :text
#  created_at           :datetime
#  updated_at           :datetime
#  device_uuid          :string(255)
#  api_key              :string(255)
#  timezone             :string(255)
#  current_version_name :string(255)
#

class DeviceSyncEntry < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :num_surveys, :current_language, :current_version_code, :instrument_versions,
                  :api_key, :device_uuid, :timezone, :current_version_name

  belongs_to :device, foreign_key: :identifier, primary_key: :device_uuid

  def instrument_versions
    JSON.parse(read_attribute(:instrument_versions)) unless read_attribute(:instrument_versions).nil?
  end
end
