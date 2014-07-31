# == Schema Information
#
# Table name: question_translations
#
#  id                        :integer          not null, primary key
#  question_id               :integer
#  language                  :string(255)
#  text                      :text
#  created_at                :datetime
#  updated_at                :datetime
#  reg_ex_validation_message :string(255)
#  question_changed          :boolean          default(FALSE)
#

class QuestionTranslation < ActiveRecord::Base
  attr_accessible :language, :text, :reg_ex_validation_message, :question_changed
  belongs_to :question
  validates :text, presence: true, allow_blank: false
end
