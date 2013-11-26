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
  attr_accessible :instrument_id, :uuid, :device_id
  belongs_to :instrument
  belongs_to :device
  
  def responses
    Response.where(survey_uuid: uuid)
  end

  def percent_complete
    (responses.uniq.pluck(:question_id).count.to_f / instrument.questions.count)
      .round(2)
  end
end
