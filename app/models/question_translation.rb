# == Schema Information
#
# Table name: question_translations
#
#  id                        :integer          not null, primary key
#  question_id               :integer
#  language                  :string(255)
#  text                      :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  reg_ex_validation_message :string(255)
#

class QuestionTranslation < ActiveRecord::Base
  attr_accessible :language, :text, :reg_ex_validation_message
  belongs_to :question

  validates :text, presence: true, allow_blank: false
end
