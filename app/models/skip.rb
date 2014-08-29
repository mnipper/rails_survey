# == Schema Information
#
# Table name: skips
#
#  id                  :integer          not null, primary key
#  option_id           :integer
#  question_identifier :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  deleted_at          :datetime
#

class Skip < ActiveRecord::Base
  attr_accessible :option_id, :question_identifier
  belongs_to :option
  acts_as_paranoid 
  validates_uniqueness_of :question_identifier, scope: :option_id, conditions: -> { where(deleted_at: nil)}
end
