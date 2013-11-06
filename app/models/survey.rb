class Survey < ActiveRecord::Base
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
