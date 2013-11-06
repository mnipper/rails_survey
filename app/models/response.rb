class Response < ActiveRecord::Base
  belongs_to :question

  def survey
    Survey.find_by_uuid(survey_uuid)
  end

  def to_s
    if question.options.empty?
      text
    else
      question.options[text.to_i]
    end
  end

end
