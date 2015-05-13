# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  identifier :string(255)
#  created_at :datetime
#  updated_at :datetime
#  label      :string(255)
#
class Device < ActiveRecord::Base
  attr_accessible :identifier, :label
  has_many :surveys
  has_many :project_devices
  has_many :projects, through: :project_devices
  has_many :device_sync_entries, foreign_key: :device_uuid, primary_key: :identifier, dependent: :destroy
  validates :identifier, uniqueness: true, presence: true, allow_blank: false

  include Comparable
  def <=> other
    return 0 if !last_sync_entry && !other.last_sync_entry
    return 1 if !last_sync_entry
    return -1 if !other.last_sync_entry
    last_sync_entry.updated_at <=> other.last_sync_entry.updated_at
  end

  def danger_zone?
    if device_sync_entries && device_sync_entries.last
      device_sync_entries.last.updated_at < Settings.danger_zone_days.days.ago
    elsif last_survey
      last_survey.updated_at.to_time < Settings.danger_zone_days.days.ago
    end
  end

  def last_survey
    surveys.order('updated_at ASC').last
  end

  def last_sync_entry
    device_sync_entries.order('updated_at ASC').last
  end

end
