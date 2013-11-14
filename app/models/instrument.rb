class Instrument < ActiveRecord::Base
  has_many :questions
  has_many :surveys
  accepts_nested_attributes_for :questions, allow_destroy: true

  def self.instrument_response_count
    @response_map = []
    Instrument.all.each do |instrument|
      instrument.questions.each do |question|
        @response_map << {instrument.title => question.responses.count }
      end
    end
    @response_map
  end

  def completion_rate
    sum = 0
    self.surveys.each do |survey|
        sum += survey.percent_complete
    end
    (sum / self.surveys.count).round(2)
  end

end
