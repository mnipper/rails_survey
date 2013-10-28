class Response < ActiveRecord::Base
  belongs_to :question
  
  def survey
    Survey.find_by_uuid(survey_uuid)
  end
end
