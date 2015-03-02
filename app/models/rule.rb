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
#  deleted_at    :time
#

class Rule < ActiveRecord::Base
  Rules = [:instrument_survey_limit_rule, :instrument_timing_rule, :instrument_survey_limit_per_minute_rule, :instrument_launch_rule, :participant_type_rule]

  belongs_to :instrument

  attr_accessible :instrument_id, :rule_type, :rule_params

  validates :rule_type, presence: true

  acts_as_paranoid

  def rule_params_hash
    JSON.parse(self.rule_params)
  end

  def self.rule_type_values(key)
    values = []
    Rules.each do |rule|
      values << Settings.rule_types.send(rule).send(key)
    end
    values
  end
end
