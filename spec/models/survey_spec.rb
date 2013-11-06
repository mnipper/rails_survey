require "spec_helper"

describe Survey do
  before :each do
    @survey = Survey.new
    @example_uuid = 'a'
    @survey.uuid = @example_uuid
  end

  it { should respond_to(:instrument) }
  it { should respond_to(:device) }
  it { should respond_to(:responses) }
  it { should respond_to(:percent_complete) }

  it "should return the correct responses" do
    response = Response.create(survey_uuid: @example_uuid)
    @survey.responses.should == [response] 
    response.destroy
  end
end
