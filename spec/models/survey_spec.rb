# == Schema Information
#
# Table name: surveys
#
#  id            :integer          not null, primary key
#  instrument_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#  uuid          :string(255)
#  device_id     :integer
#

require "spec_helper"

describe Survey do
  it { should respond_to(:instrument) }
  it { should respond_to(:device) }
  it { should respond_to(:responses) }
  it { should respond_to(:percent_complete) }

  it "should return the correct responses" do
    @survey = build(:survey) 
    response = Response.create(survey_uuid: @survey.uuid)
    @survey.responses.should == [response] 
  end
end
