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
