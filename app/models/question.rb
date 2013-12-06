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
  include Translatable
  attr_accessible :text, :question_type, :question_identifier, :instrument_id, :options_attributes
  belongs_to :instrument
  has_many :responses
  has_many :options
  has_many :translations, foreign_key: 'question_id', class_name: 'QuestionTranslation'
  accepts_nested_attributes_for :options, allow_destroy: true
  after_save :parent_update_count
  has_paper_trail

  validates :question_identifier, uniqueness: true

  def has_options?
    !options.empty?
  end

  private
  def parent_update_count
    instrument.increment!(:child_update_count)
  end
end
