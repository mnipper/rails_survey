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

require "spec_helper"

describe Question do
  it { should respond_to(:options) }
  it { should respond_to(:instrument) }
end
