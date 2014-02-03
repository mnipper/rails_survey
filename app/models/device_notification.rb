# == Schema Information
#
# Table name: device_notifications
#
#  id         :integer          not null, primary key
#  time       :text
#  monday     :boolean
#  tuesday    :boolean
#  wednesday  :boolean
#  thursday   :boolean
#  friday     :boolean
#  saturday   :boolean
#  sunday     :boolean
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

class DeviceNotification < ActiveRecord::Base
  attr_accessible :time, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday,
    :sunday, :message
  belongs_to :instrument
  validates :message, presence: true, allow_blank: false
  validates :time, presence: true, allow_blank: false, 
    format: { with: /\A\d{2}:\d{2}\z/, message: " is not a valid time" }
end
