# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  identifier :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Device < ActiveRecord::Base
  attr_accessible :identifier
  has_many :surveys
  has_many :project_devices
  has_many :projects, through: :project_devices
  validates :identifier, uniqueness: true, presence: true, allow_blank: false

  def danger_zone?
    unless last_survey.nil?
      last_survey.updated_at < 1.day.ago
    end
  end

  def last_survey
    surveys.order('updated_at ASC').last
  end
end
