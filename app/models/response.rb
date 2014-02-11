# == Schema Information
#
# Table name: responses
#
#  id                  :integer          not null, primary key
#  question_id         :integer
#  text                :string(255)
#  other_response      :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  survey_uuid         :string(255)
#  special_response    :string(255)
#  time_started        :datetime
#  time_ended          :datetime
#  question_identifier :string(255)
#

class Response < ActiveRecord::Base
  attr_accessible :question_id, :text, :other_response, :special_response, :survey_uuid,
    :time_started, :time_ended, :question_identifier
  belongs_to :question
  belongs_to :survey, foreign_key: :survey_uuid, primary_key: :uuid
  delegate :device, to: :survey 
  delegate :instrument, to: :survey
  delegate :project, to: :survey
  delegate :instrument_version_number, to: :survey

  validates :question, presence: true
  validates :survey, presence: true

  def to_s
    if question.options.empty?
      text
    else
      question.options[text.to_i].to_s
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      export(csv)
    end
  end

  def self.export(format)
    format << ['qid', 'instrument_id', 'instrument_version_number', 'instrument_title', 
      'survey_uuid', 'device_id', 'response', 'special_response', 'other_response']
    all.each do |response|
      format << [response.question_identifier, response.survey.instrument_id,
        response.instrument_version_number, response.survey.instrument_title,
        response.survey_uuid, response.survey.device_uuid, response.text,
        response.special_response, response.other_response]
    end
  end

  def grouped_responses
    self.group(:created_at)
  end

  def versioned_response
    if question.options.empty? or text.empty? or text !~ /^[-+]?[0-9]+$/
      text
    else
      question.options[text.to_i].version_at_time(survey.instrument_version.updated_at)
    end
  end

  def time_taken_in_seconds
    if time_ended && time_started
      time_ended - time_started
    end
  end
  
end
