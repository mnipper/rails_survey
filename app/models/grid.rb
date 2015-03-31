# == Schema Information
#
# Table name: grids
#
#  id            :integer          not null, primary key
#  instrument_id :integer
#  question_type :string(255)
#  name          :string(255)
#  option_texts  :text
#  created_at    :datetime
#  updated_at    :datetime
#

class Grid < ActiveRecord::Base
  belongs_to :instrument
  has_many :questions
  serialize :option_texts
  
end
