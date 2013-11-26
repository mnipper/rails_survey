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
  has_many :surveys
  validates :identifier, uniqueness: true  

  def danger_zone?
    last_survey.updated_at < 1.day.ago
  end

  def last_survey
    surveys.order('updated_at ASC').last
  end
end
