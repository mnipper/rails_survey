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
  Rules = [:instrument_survey_limit_rule]

  belongs_to :instrument

  validates :rule_type, presence: true

  def rule_params_hash
    JSON.parse(self.rule_params)
  end

  def self.rule_type_values(key)
    constants = []
    Rules.each do |rule|
      constants << Settings.rule_types.send(rule).send(key)
    end
    constants
  end
end
