# == Schema Information
#
# Table name: instruments
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  language   :string(255)
#  alignment  :string(255)
#

require "spec_helper"

describe Instrument do
  it { should respond_to(:questions) }
  it { should respond_to(:surveys) }
end
