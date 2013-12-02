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
end
