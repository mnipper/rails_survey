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
  
  def danger_zone?
    unless last_survey.nil?
      last_survey.updated_at < Settings.danger_zone_days.days.ago
    end
  end

  def last_survey
    surveys.order('updated_at ASC').last
  end
  
  def completion_rate
    percentages = []
    surveys.each do |survey|
      percentages << survey.percent_complete
    end
    (percentages.sum/percentages.length).round(2) 
  end
  
end
