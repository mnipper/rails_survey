# == Schema Information
#
# Table name: grid_labels
#
#  id         :integer          not null, primary key
#  label      :text
#  grid_id    :integer
#  option_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class GridLabel < ActiveRecord::Base
  attr_accessible :label, :grid_id, :option_id
  belongs_to :grid
  belongs_to :option
  validates :label, presence: true, allow_blank: false
end
