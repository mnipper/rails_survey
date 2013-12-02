# == Schema Information
#
# Table name: surveys
#
#  id            :integer          not null, primary key
#  instrument_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#  uuid          :string(255)
#  device_id     :integer
#

class Survey < ActiveRecord::Base
  attr_accessible :instrument_id, :instrument_version_number, :uuid, :device_id
  belongs_to :instrument
  belongs_to :device
  has_many :responses, foreign_key: :survey_uuid, primary_key: :uuid
  
  def percent_complete
    (responses.pluck(:question_id).uniq.count.to_f / instrument.questions.count)
      .round(2)
  end
end
