# == Schema Information
#
# Table name: surveys
#
#  id                        :integer          not null, primary key
#  instrument_id             :integer
#  created_at                :datetime
#  updated_at                :datetime
#  uuid                      :string(255)
#  device_id                 :integer
#  instrument_version_number :integer
#  instrument_title          :string(255)
#  device_uuid               :string(255)
#  latitude                  :string(255)
#  longitude                 :string(255)
#

class Survey < ActiveRecord::Base
  attr_accessible :instrument_id, :instrument_version_number, :uuid, :device_id, :instrument_title,
    :device_uuid, :latitude, :longitude
  belongs_to :instrument
  belongs_to :device
  has_many :responses, foreign_key: :survey_uuid, primary_key: :uuid, dependent: :destroy
  delegate :project, to: :instrument
  
  validates :device_id, presence: true, allow_blank: false
  validates :uuid, presence: true, allow_blank: false
  validates :instrument_id, presence: true, allow_blank: false
  validates :instrument_version_number, presence: true, allow_blank: false
  
  def percent_complete
    (responses.pluck(:question_id).uniq.count.to_f / instrument_version_question_count)
      .round(2)
  end

  def instrument_version
    if instrument.is_version? instrument_version_number
      instrument
    else
      instrument.versions[instrument_version_number].reify
    end
  end

  def instrument_version_question_count
    if instrument.is_version? instrument_version_number
      instrument.question_count
    else
      instrument.question_count_for_version(instrument_version.version, instrument_version_number)
    end
  end

  def location
    unless latitude.nil? or longitude.nil?
      latitude + ' / ' + longitude
    end
  end
  
  def group_responses_by_day
    self.responses.group_by_day(:created_at).count 
  end
  
  def group_responses_by_hour
    self.responses.group_by_hour_of_day(:created_at).count
  end

end
