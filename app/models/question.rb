# == Schema Information
#
# Table name: questions
#
#  id                  :integer          not null, primary key
#  text                :string(255)
#  question_type       :string(255)
#  question_identifier :string(255)
#  instrument_id       :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class Question < ActiveRecord::Base
  attr_accessible :text, :question_type, :question_identifier, :instrument_id, :options_attributes
  belongs_to :instrument
  has_many :responses
  has_many :options
  accepts_nested_attributes_for :options, allow_destroy: true
  has_paper_trail
  has_many :translations, foreign_key: 'question_id', class_name: 'QuestionTranslation'

  def has_translation_for?(language)
    self.translations.find_by_language(language)
  end

  def translated_for(language)
    self.translations.find_by_language(language).text if has_translation_for? language
  end

  def has_options?
    !options.empty?
  end
end
