# == Schema Information
#
# Table name: device_sync_entries
#
#  id                  :integer          not null, primary key
#  latitude            :string(255)
#  longitude           :string(255)
#  num_surveys         :integer
#  current_language    :string(255)
#  current_version     :string(255)
#  instrument_versions :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  device_id           :integer
#  api_key             :string(255)
#

class DeviceSyncEntry < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :num_surveys, :current_language, :current_version, :instrument_versions,
                  :api_key
  belongs_to :device
end
