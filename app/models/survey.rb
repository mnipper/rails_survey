class Survey < ActiveRecord::Base
  belongs_to :instrument
  
  def responses
    Response.where(survey_uuid: uuid)
  end
end
