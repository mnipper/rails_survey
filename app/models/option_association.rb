class OptionAssociation < ActiveRecord::Base
  attr_accessible :option_id, :question_id, :option_version, :question_version
  belongs_to :option
  validates :question_id, presence: true, allow_blank: false
  validates :question_version, presence: true, allow_blank: false
  validates :option_version, presence: true, allow_blank: false
  validates :option_id, presence: true, allow_blank: false
end
