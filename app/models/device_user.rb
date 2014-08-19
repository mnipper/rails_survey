# == Schema Information
#
# Table name: device_users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  active          :boolean
#  device_id       :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class DeviceUser < ActiveRecord::Base
  has_secure_password
  belongs_to :device
end
