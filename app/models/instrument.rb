class Instrument < ActiveRecord::Base
  has_many :questions
  has_many :surveys
  accepts_nested_attributes_for :questions, allow_destroy: true

  def self.instrument_response_count
    @response_map = []
    all_instruments = Instrument.all
    all_instruments.each do |instrument|
      instrument.questions.each do |question|
        @response_map << {instrument.title => question.response_count }
      end
    end
    @response_map
  end

end
