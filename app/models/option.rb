# == Schema Information
#
# Table name: options
#
#  id            :integer          not null, primary key
#  question_id   :integer
#  text          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  next_question :string(255)
#

class Option < ActiveRecord::Base
  include Translatable
  attr_accessible :question_id, :text, :next_question
  belongs_to :question
  has_many :option_translations
  has_many :translations, foreign_key: 'option_id', class_name: 'OptionTranslation'
  has_paper_trail

  def to_s
    text
  end
end
