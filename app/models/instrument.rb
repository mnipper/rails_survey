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

  def self.general_statistics
    {
    'Percentage of completion' => 'TBD',
    'Average time to complete survey' => 'TBD',
    'Most skipped question' => 'TBD',
    'Most answered question' => 'TBD',
    'Most responsive respondents' => 'TBD',
    'Least responsive respondents' => 'TBD'
    }
  end

end
