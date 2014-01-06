class QuestionAssociation < ActiveRecord::Base
  attr_accessible :question_id, :instrument_id, :question_version, :instrument_version
  belongs_to :question
  validates :question_id, presence: true, allow_blank: false
  validates :question_version, presence: true, allow_blank: false
  validates :instrument_version, presence: true, allow_blank: false
  validates :instrument_id, presence: true, allow_blank: false

end
