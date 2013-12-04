# == Schema Information
#
# Table name: surveys
#
#  id                        :integer          not null, primary key
#  instrument_id             :integer
#  created_at                :datetime
#  updated_at                :datetime
#  uuid                      :string(255)
#  device_id                 :integer
#  instrument_version_number :integer
#

require "spec_helper"

describe Survey do
  it { should respond_to(:instrument) }
  it { should respond_to(:device) }
  it { should respond_to(:responses) }
  it { should respond_to(:percent_complete) }

  it "should return the correct responses" do
    @survey = build(:survey) 
    response = Response.new(question_id: 1)
    response.survey = @survey
    response.save!
    @survey.responses.should == [response]
  end
end
