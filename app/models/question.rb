class Question < ActiveRecord::Base
  belongs_to :instrument
  has_many :responses
  has_many :options
  accepts_nested_attributes_for :options, allow_destroy: true

  def self.ids_for_single_and_multiple_select_questions(question_type)
    Question.select(:id).where(:question_type => question_type)
  end

end
