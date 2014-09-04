# == Schema Information
#
# Table name: rules
#
#  id            :integer          not null, primary key
#  rule_type     :string(255)
#  instrument_id :integer
#  rule_params   :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Rule < ActiveRecord::Base
  belongs_to :instrument

  validates :rule_type, presence: true
end
