# == Schema Information
#
# Table name: instruments
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  language   :string(255)
#  alignment  :string(255)
#

class Instrument < ActiveRecord::Base
  has_many :questions
  has_many :surveys
  attr_accessible :title, :language, :alignment, :questions_attributes
  accepts_nested_attributes_for :questions, allow_destroy: true
  before_save :set_language_alignment
  has_paper_trail

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
    sum = 0.0
    self.surveys.each do |survey|
        sum += survey.percent_complete
    end
    (sum / self.surveys.count).round(2)
  end

  def response_count_per_day
    questions = self.questions.all
    responses = []
    questions.each do |question|
      responses << question.responses.select('DATE(created_at)').count(:group => 'DATE(created_at)')
    end
    responses.inject{|result, element| result.merge( element ){|k, old_v, new_v| old_v + new_v}}
  end

  private
  def set_language_alignment
    self.alignment = Settings.right_align_languages.include? self.language ? 'right' : 'left'
    nil
  end
end
