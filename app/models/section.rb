# == Schema Information
#
# Table name: sections
#
#  id                        :integer          not null, primary key
#  title                     :string(255)
#  start_question_identifier :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  instrument_id             :integer
#

class Section < ActiveRecord::Base
  attr_accessible :title, :start_question_identifier, :instrument_id 
  belongs_to :instrument 
  validates :title, presence: true
  validates :start_question_identifier, presence: true
  #TODO ensure that start_question_identifier corresponds to an existing q_id && no sections start with same q_id
end
