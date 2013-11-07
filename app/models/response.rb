class Response < ActiveRecord::Base
  belongs_to :question

  def survey
    Survey.find_by_uuid(survey_uuid)
  end

  def to_s
    if question.options.empty?
      text
    else
      question.options[text.to_i].to_s
    end
  end

  def self.responses_by_hour
    map = {}
    (0..23).each do |hour|
      map[hour] = 0
    end
    responses = Response.all
    responses.each do |response|
      hr = response.created_at.hour
      old_value = map[hr]
      map[hr] = old_value + 1
    end
    map
  end

end
