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
#  metadata                  :text
#

class Survey < ActiveRecord::Base
  attr_accessible :instrument_id, :instrument_version_number, :uuid, :device_id, :instrument_title,
    :device_uuid, :latitude, :longitude, :metadata
  belongs_to :instrument
  belongs_to :device
  has_many :responses, foreign_key: :survey_uuid, primary_key: :uuid, dependent: :destroy
  delegate :project, to: :instrument
  
  validates :device_id, presence: true, allow_blank: false
  validates :uuid, presence: true, allow_blank: false
  validates :instrument_id, presence: true, allow_blank: false
  validates :instrument_version_number, presence: true, allow_blank: false
  
  def percent_complete
    #TODO: Fix instrument versioning
    (responses.where.not(:text => "").pluck(:question_id).uniq.count.to_f / instrument.questions.count).round(2)
  end

  def location
    "#{latitude} / #{longitude}" if latitude and longitude
  end
  
  def group_responses_by_day
    self.responses.group_by_day(:created_at).count 
  end
  
  def group_responses_by_hour
    self.responses.group_by_hour_of_day(:created_at).count
  end

  def instrument_version
    instrument.version_by_version_number(instrument_version_number)
  end

  def location_link
    "https://www.google.com/maps/place/#{latitude}+#{longitude}" if latitude and longitude
  end

  def metadata
    JSON.parse(read_attribute(:metadata)) unless read_attribute(:metadata).nil?
  end
end
