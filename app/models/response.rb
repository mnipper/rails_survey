class Response < ActiveRecord::Base
  belongs_to :question

  after_create {|response| response.delta 'create' }
  after_update {|response| response.delta 'update' }
  after_destroy {|response| response.delta 'destroy' }

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

  def delta act
      message = {
          action: act,
          id: self.id,
          total: Response.count,
          object: self
      }
      $redis.publish 'rt-change', message.to_json
  end

end
