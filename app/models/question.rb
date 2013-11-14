class Question < ActiveRecord::Base
  belongs_to :instrument
  has_many :responses
  has_many :options
  accepts_nested_attributes_for :options, allow_destroy: true

  def self.ids_for_select_one_questions
    Question.select(:id).where(:question_type => 'SELECT_ONE')
  end
end
