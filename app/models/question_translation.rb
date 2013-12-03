# == Schema Information
#
# Table name: question_translations
#
#  id          :integer          not null, primary key
#  question_id :integer
#  language    :string(255)
#  text        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class QuestionTranslation < ActiveRecord::Base
  attr_accessible :language, :text
  belongs_to :question
end
