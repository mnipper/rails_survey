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
  attr_accessible :identifer
  has_many :surveys
  validates :identifier, uniqueness: true, presence: true, allow_blank: false

  def danger_zone?
    last_survey.updated_at < 1.day.ago
  end

  def last_survey
    surveys.order('updated_at ASC').last
  end
end
