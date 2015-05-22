# == Schema Information
#
# Table name: device_users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  name            :string(255)
#  password_digest :string(255)
#  active          :boolean          default(FALSE)
#  device_id       :integer
#  created_at      :datetime
#  updated_at      :datetime
#  project_id      :integer
#

class DeviceUser < ActiveRecord::Base
  has_secure_password

  attr_accessible :name, :username, :password, :password_confirmation, :active

  belongs_to :device
  belongs_to :project
  validates :username, presence: true, uniqueness: true, allow_blank: false
  validates :name, presence: true
  validates :password_digest, presence: true
end
